import CoreClient
import Entity
import FirebaseAuth
import FirebaseCore

extension LoginClient {
    public static func configure() {
        FirebaseApp.configure()
    }
    public static var product: LoginClient {
        LoginClient { email, password in
            do {
                let user = try await Auth.auth().signIn(withEmail: email.rawValue, password: password)
                return Entity.User.ID(rawValue: user.user.uid)
            } catch {
                throw LoginError(from: error)
            }
        }
    }
}

extension LoginError {
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
