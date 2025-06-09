import CoreClient
import FirebaseAuth
import FirebaseCore

extension LoginClient {
    public static func configure() {
        FirebaseApp.configure()
    }
    public static var product: LoginClient {
        LoginClient { _, _ in
            ""
        }
    }
}
