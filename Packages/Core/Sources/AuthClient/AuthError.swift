import FirebaseAuth

public enum AuthError: Error {
    case invalidEmail
    case weakPassword
    case wrongPassword
    case userNotFound
    case unexpected((any Error)?)

    init(from error: any Error) {
        let nsError = error as NSError
        if let code = AuthErrorCode(rawValue: nsError.code) {
            switch code {
            case .invalidEmail:
                self = .invalidEmail
            case .weakPassword:
                self = .weakPassword
            case .wrongPassword:
                self = .wrongPassword
            case .userNotFound:
                self = .userNotFound
            default:
                self = .unexpected(error as NSError)
            }
        } else {
            self = .unexpected(nil)
        }
    }
}
