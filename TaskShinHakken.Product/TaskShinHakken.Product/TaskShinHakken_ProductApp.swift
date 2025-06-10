import AuthClient
import SwiftUI
import ProductAppFeature

@main
struct TaskShinHakken_ProductApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init() {
        print("⭐️ TaskShinHakken.ProductApp started")
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AuthClient.configure()

        return true
    }
}
