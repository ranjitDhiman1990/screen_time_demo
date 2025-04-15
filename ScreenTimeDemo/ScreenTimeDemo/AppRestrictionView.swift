//
//  AppRestrictionView.swift
//  ScreenTimeDemo
//
//  Created by Dhiman Ranjit on 15/04/25.
//

import SwiftUI
import FamilyControls

struct AppRestrictionView: View {
    @StateObject var model = ScreenTimeModel()
    @State var selection = FamilyActivitySelection()
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Select Apps to Restrict") {
                model.presentPicker(selection: $selection)
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button("Apply Restrictions") {
                model.applyRestrictions(selection: selection)
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(selection.applicationTokens.isEmpty && selection.categoryTokens.isEmpty)
            
            Button("Remove All Restrictions") {
                model.removeAllRestrictions()
            }
            .buttonStyle(DestructiveButtonStyle())
        }
        .familyActivityPicker(
            isPresented: $model.isPickerPresented,
            selection: $selection
        )
    }
}


struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct DestructiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
