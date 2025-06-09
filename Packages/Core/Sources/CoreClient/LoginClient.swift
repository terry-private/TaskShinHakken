import ComposableArchitecture
import Entity

public enum LoginError: Error {
    case invalidEmail
    case weakPassword
    case wrongPassword
    case userNotFound
    case unexpected((any Error)?)
}

public struct LoginClient: Sendable {
    public var login: @Sendable (EMail, String) async throws -> User.ID

    public init(login: @escaping @Sendable (EMail, String) async throws -> User.ID) {
        self.login = login
    }
}

extension LoginClient: DependencyKey {
    public static var liveValue: LoginClient {
        LoginClient { _, _ in
            try await Task.sleep(for: .seconds(1))
            return "user-id"
        }
    }
}

extension DependencyValues {
    public var loginClient: LoginClient {
        get {
            self[LoginClient.self]
        }
        set {
            self[LoginClient.self] = newValue
        }
    }
}
