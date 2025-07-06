import ComposableArchitecture
import Entity
import FirebaseFirestore

public struct UserClient: Sendable {
    public var getUserSetupStatus: @Sendable (Entity.User.ID) async throws -> Bool
    
    public init(
        getUserSetupStatus: @escaping @Sendable (Entity.User.ID) async throws -> Bool
    ) {
        self.getUserSetupStatus = getUserSetupStatus
    }
}

public struct UserClientError: Error, Equatable {
    public let localizedDescription: String
    
    public init(from error: Error) {
        self.localizedDescription = error.localizedDescription
    }
    
    public init(message: String) {
        self.localizedDescription = message
    }
}

extension UserClient: DependencyKey {
    public static var liveValue: UserClient {
        UserClient(
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
                    throw UserClientError(from: error)
                }
            }
        )
    }
    
    public static var previewValue: UserClient {
        UserClient(
            getUserSetupStatus: { _ in
                try await Task.sleep(for: .seconds(0.5))
                return false // プレビューでは常に未セットアップ
            }
        )
    }
}

extension DependencyValues {
    public var userClient: UserClient {
        get {
            self[UserClient.self]
        }
        set {
            self[UserClient.self] = newValue
        }
    }
}