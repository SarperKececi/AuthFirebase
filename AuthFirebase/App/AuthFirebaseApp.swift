//
//  AuthFirebaseApp.swift
//  AuthFirebase
//
//  Created by Sarper Kececi on 23.12.2023.
//

import SwiftUI
import Firebase

@main
struct AuthFirebaseApp: App {
    init() {
           FirebaseApp.configure()
       }
    
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
