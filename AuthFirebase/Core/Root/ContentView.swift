//
//  ContentView.swift
//  AuthFirebase
//
//  Created by Sarper Kececi on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack {
            if viewModel.userSessions != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
