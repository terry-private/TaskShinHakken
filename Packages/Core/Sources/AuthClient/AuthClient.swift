import ComposableArchitecture
import Entity
import FirebaseAuth
import FirebaseCore

public struct AuthClient: Sendable {
    public static func configure() {
        FirebaseApp.configure()
    }
    public var autoLogin: @Sendable () -> Entity.User.ID?
    public var login: @Sendable (EMail, String) async throws -> Entity.User.ID
    public var signUp: @Sendable (EMail, String) async throws -> Entity.User.ID

    public init(
        autoLogin: @escaping @Sendable () -> Entity.User.ID?,
        login: @escaping @Sendable (EMail, String) async throws -> Entity.User.ID,
        signUp: @escaping @Sendable (EMail, String) async throws -> Entity.User.ID
    ) {
        self.autoLogin = autoLogin
        self.login = login
        self.signUp = signUp
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
