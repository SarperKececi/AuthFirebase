//
//  ProfileView.swift
//  AuthFirebase
//
//  Created by Sarper Kececi on 24.12.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
   
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(viewModel.currentUser?.initals ?? "nil")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72 , height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        VStack {
                            Text(viewModel.currentUser?.fullName ?? "nil")
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text(viewModel.currentUser?.email ?? "nil")
                                .font(.footnote)
                                
                        }
                        
                    }
                }
                Section("General") {
                    HStack {
                        SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.black))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        
                    }
                    
                   
                   
                    
                  
                }
                Section("Account") {
                    Button {
                        viewModel.signOut()
              
               
                    } label: {
                        SettingRowView(imageName: "arrow.left.circle.fill", title: "Sign out.", tintColor: Color.red)
                    }
                    
                    
                    Button {
                        viewModel.deleteAccount()
                    } label: {
                        SettingRowView(imageName: "xmark.circle.fill", title: "Delete account", tintColor: .red)
                    }

                    
                    
                    
                }
                
            }
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
