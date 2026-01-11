//
//  KixApp.swift
//  Kix
//
//  Created by Konstanty Halets on 06/01/2026.
//

import SwiftUI

@main
struct KixApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            AuthRouterView()
                .environmentObject(appState)
        }
    }
}

