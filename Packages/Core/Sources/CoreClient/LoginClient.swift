import ComposableArchitecture
import Entity

public struct LoginClient: Sendable {
    public var login: @Sendable () async throws -> User.ID

    init(login: @escaping @Sendable () async throws -> User.ID) {
        self.login = login
    }
}

extension LoginClient: DependencyKey {
    public static var liveValue: LoginClient {
        LoginClient {
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
