//
//  ContentView.swift
//  ScreenTimeDemo
//
//  Created by Dhiman Ranjit on 15/04/25.
//

import SwiftUI
import FamilyControls
import ManagedSettings

struct ContentView: View {
    @StateObject var model = ScreenTimeModel()
    
    var body: some View {
        VStack {
            if model.isAuthorized {
                AppRestrictionView()
            } else {
                Button("Request Screen Time Access") {
                    Task {
                        await model.requestAuthorization()
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
