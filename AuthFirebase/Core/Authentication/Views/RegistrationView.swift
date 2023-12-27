import SwiftUI

struct RegistrationView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var fullName: String = ""
    @State var confirmPassword: String = ""
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            Image("firebaselogo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical,32)

            VStack(spacing: 24) {
                InputView(text: $fullName, title: "enter your full name.", placeholder: "Name:", secureField: false)

                InputView(text: $email, title: "Email Adress", placeholder: "@example.com", secureField: false)
                    .autocapitalization(.none)

                InputView(text: $password, title: "Password", placeholder: "3434", secureField: false)

                InputView(text: $confirmPassword, title: "Confirm Password:", placeholder: "3434", secureField: false)
            }
            .padding(.horizontal)
            .padding(.top, 22)

            Button {
                Task {
                    do {
                        try await viewModel.createUser(withEmail: email, fullName: fullName, password: password)
                        dismiss()
                    } catch {
                        alertMessage = error.localizedDescription
                        showAlert.toggle()
                    }
                }
            } label: {
                HStack {
                    Text("Sign Up!")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
            }
            .foregroundColor(.white)
            .frame(width: 150, height: 40)
            .background(Color.blue)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

            Spacer()

            Button {
                dismiss()
            } label: {
                HStack(spacing: 2) {
                    Text("Already have an account?")
                    Text("Sign In!")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}
extension RegistrationView : AuhthenticationProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && confirmPassword == password
        
    }
    
    
}
