//
//  KixApp.swift
//  Kix
//
//  Created by Konstanty Halets on 06/01/2026.
//

import SwiftUI
import CoreData

@main
struct KixApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appState)
        }
    }
}
