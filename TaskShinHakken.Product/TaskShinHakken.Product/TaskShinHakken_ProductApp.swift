//
//  TaskShinHakken_ProductApp.swift
//  TaskShinHakken.Product
//
//  Created by Teruhito Wakae on 2025/05/31.
//

import SwiftUI
import ProductAppFeature

@main
struct TaskShinHakken_ProductApp: App {
    var body: some Scene {
        WindowGroup {
            TaskShinHakkenApp.createRootView()
        }
    }
}
