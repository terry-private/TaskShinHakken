import ComposableArchitecture
import Entity
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

public struct AuthClient: Sendable {
    public static func configure() {
        FirebaseApp.configure()
    }
    public var autoLogin: @Sendable () -> Entity.User.ID?
    public var login: @Sendable (EMail, String) async throws -> Entity.User.ID
    public var signUp: @Sendable (EMail, String) async throws -> Entity.User.ID
    public var signOut: @Sendable () throws -> Void
    public var appleSignIn: @Sendable () async throws -> Entity.User.ID
    public var sendPasswordResetEmail: @Sendable (EMail) async throws -> Void
    public var getUserSetupStatus: @Sendable (Entity.User.ID) async throws -> Bool

    public init(
        autoLogin: @escaping @Sendable () -> Entity.User.ID?,
        login: @escaping @Sendable (EMail, String) async throws -> Entity.User.ID,
        signUp: @escaping @Sendable (EMail, String) async throws -> Entity.User.ID,
        signOut: @escaping @Sendable () throws -> Void,
        appleSignIn: @escaping @Sendable () async throws -> Entity.User.ID,
        sendPasswordResetEmail: @escaping @Sendable (EMail) async throws -> Void,
        getUserSetupStatus: @escaping @Sendable (Entity.User.ID) async throws -> Bool
    ) {
        self.autoLogin = autoLogin
        self.login = login
        self.signUp = signUp
        self.signOut = signOut
        self.appleSignIn = appleSignIn
        self.sendPasswordResetEmail = sendPasswordResetEmail
        self.getUserSetupStatus = getUserSetupStatus
    }
}

extension AuthClient: DependencyKey {
    public static var liveValue: AuthClient {
        AuthClient(
            autoLogin: {
                guard let uid = Auth.auth().currentUser?.uid else {
                    return nil
                }
                return Entity.User.ID(rawValue: uid)
            },
            login: { email, password in
                do {
                    let user = try await Auth.auth().signIn(withEmail: email.rawValue, password: password)
                    return Entity.User.ID(rawValue: user.user.uid)
                } catch {
                    throw AuthError(from: error)
                }
            },
            signUp: { email, password in
                do {
                    let user = try await Auth.auth().createUser(withEmail: email.rawValue, password: password)
                    return Entity.User.ID(rawValue: user.user.uid)
                } catch {
                    throw AuthError(from: error)
                }
            },
            signOut: {
                do {
                    try Auth.auth().signOut()
                } catch {
                    throw AuthError(from: error)
                }
            },
            appleSignIn: { @MainActor in
                do {
                    let result = try await AppleSignInManager().handleSignInWithApple()
                    return Entity.User.ID(rawValue: result.user.uid)
                } catch {
                    throw AuthError(from: error)
                }
            },
            sendPasswordResetEmail: { email in
                do {
                    try await Auth.auth().sendPasswordReset(withEmail: email.rawValue)
                } catch {
                    throw AuthError(from: error)
                }
            },
            getUserSetupStatus: { userID in
                do {
                    let db = Firestore.firestore()
                    let userDoc = try await db.collection("users").document(userID.rawValue).getDocument()
                    
                    guard userDoc.exists,
                          let data = userDoc.data(),
                          let isSetupCompleted = data["isSetupCompleted"] as? Bool else {
                        // ユーザードキュメントが存在しない場合は未セットアップとみなす
                        return false
                    }
                    
                    return isSetupCompleted
                } catch {
                    throw AuthError(from: error)
                }
            }
        )
    }

    public static var previewValue: AuthClient {
        AuthClient (
            autoLogin: {
                nil
            },
            login: { _, _ in
                try await Task.sleep(for: .seconds(1))
                return "user-id"
            },
            signUp: { _, _ in
                try await Task.sleep(for: .seconds(1))
                return "user-id"
            },
            signOut: {
                // Do nothing
            },
            appleSignIn: {
                "user-id"
            },
            sendPasswordResetEmail: { _ in
                // Do nothing
            },
            getUserSetupStatus: { _ in
                try await Task.sleep(for: .seconds(0.5))
                return false // プレビューでは常に未セットアップ
            }
        )
    }
}

extension DependencyValues {
    public var authClient: AuthClient {
        get {
            self[AuthClient.self]
        }
        set {
            self[AuthClient.self] = newValue
        }
    }
}
