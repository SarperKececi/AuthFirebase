//
//  LoginView.swift
//  AuthFirebase
//
//  Created by Sarper Kececi on 23.12.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email : String = ""
    @State private var password : String = ""
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Image("firebaselogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical,32)
                
                VStack(spacing : 24) {
                    InputView(text: $email, title: "Email Adress", placeholder: "@example.com", secureField: false)
                        .autocapitalization(.none)
                     InputView(text: $password, title: "Password", placeholder: "3434" , secureField: true)
                }
                .padding(.horizontal)
                .padding(.top , 22)
                 
                Button{
                    Task {
                        do {
                            try await viewModel.signIn(withEmail: email, password: password)
                            
                        } catch {
                            // Hata durumu ile ilgili işlemler burada gerçekleştirilir
                        }
                    }
                } label: {
                    
                    HStack{
                       Text("Sign In!")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                        
                    }
                }
                .foregroundColor(.white)
                .frame(width: 150, height: 40) // İstediğiniz genişliği ayarlayabilirsiniz
                .background(Color.blue)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top)
                
                   
            }
            
            
            .foregroundColor(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top , 24)
            
            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarBackButtonHidden()
            } label: {
                
                HStack(spacing : 2){
                    Text("Don't have an account")
                    Text("Sign up")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }

        }
    }
}
extension LoginView : AuhthenticationProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
