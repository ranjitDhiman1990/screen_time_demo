//
//  ScreenTimeModel.swift
//  ScreenTimeDemo
//
//  Created by Dhiman Ranjit on 15/04/25.
//

import SwiftUI
import FamilyControls
import ManagedSettings

class ScreenTimeModel: ObservableObject {
    @Published var isAuthorized = false
    @Published var isPickerPresented = false
    
    private var observer: Any?
    
    init() {
        checkAuthorization()
        
        observer = NotificationCenter.default.addObserver(
            forName: Notification.Name("ManagedSettingsStore.didChangeNotification"),
            object: nil,
            queue: nil
        ) { _ in
            print("Screen Time settings changed")
        }
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func checkAuthorization() {
        isAuthorized = AuthorizationCenter.shared.authorizationStatus == .approved
    }
    
    func requestAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            DispatchQueue.main.async {
                self.checkAuthorization()
            }
        } catch {
            print("Failed to request authorization: \(error)")
        }
    }
    
    func presentPicker(selection: Binding<FamilyActivitySelection>) {
        isPickerPresented = true
    }
    
    func applyRestrictions(selection: FamilyActivitySelection) {
        let store = ManagedSettingsStore()

            store.shield.applications = selection.applicationTokens
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(selection.categoryTokens)
            store.shield.webDomains = selection.webDomainTokens
        
        // Save the selection for later use
        UserDefaults.standard.set(try? JSONEncoder().encode(selection), forKey: "selection")
    }
    
    func removeAllRestrictions() {
        let store = ManagedSettingsStore()
        store.clearAllSettings()
        UserDefaults.standard.removeObject(forKey: "selection")
    }
}
