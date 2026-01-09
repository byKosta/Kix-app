//
//  ContentView.swift
//  Kix
//
//  Created by Konstanty Halets on 06/01/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isAuthenticated {
            MainTabView()
                .environmentObject(authViewModel)
        } else {
            LoginView()
                .environmentObject(authViewModel)
        }
    }
}

#Preview {
    ContentView()
}
