import ComposableArchitecture
import Entity
import FirebaseAuth
import FirebaseCore

public struct AuthClient: Sendable {
    public static func configure() {
        FirebaseApp.configure()
    }
    public var login: @Sendable (EMail, String) async throws -> Entity.User.ID

    public init(login: @escaping @Sendable (EMail, String) async throws -> Entity.User.ID) {
        self.login = login
    }
}

extension AuthClient: DependencyKey {
    public static var liveValue: AuthClient {
        AuthClient { email, password in
            do {
                let user = try await Auth.auth().signIn(withEmail: email.rawValue, password: password)
                return Entity.User.ID(rawValue: user.user.uid)
            } catch {
                throw AuthError(from: error)
            }
        }
    }

    public static var previewValue: AuthClient {
        AuthClient { _, _ in
            try await Task.sleep(for: .seconds(1))
            return "user-id"
        }
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
