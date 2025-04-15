//
//  ScreenTimeDemoApp.swift
//  ScreenTimeDemo
//
//  Created by Dhiman Ranjit on 15/04/25.
//

import SwiftUI
import FamilyControls

@main
struct ScreenTimeDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Initialize the authorization state
                    let center = AuthorizationCenter.shared
                    if center.authorizationStatus == .approved {
                        // Already authorized
                    }
                }
        }
    }
}
