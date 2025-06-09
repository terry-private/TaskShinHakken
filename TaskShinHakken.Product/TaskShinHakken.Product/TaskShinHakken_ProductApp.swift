//
//  TaskShinHakken_ProductApp.swift
//  TaskShinHakken.Product
//
//  Created by Teruhito Wakae on 2025/05/31.
//
import CoreClient
import CoreClientProduct
import SwiftUI
import ProductAppFeature

@main
struct TaskShinHakken_ProductApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      LoginClient.configure()

      return true
    }
  }
