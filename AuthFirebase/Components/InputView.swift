    //
    //  InputView.swift
    //  AuthFirebase
    //
    //  Created by Sarper Kececi on 23.12.2023.
    //

    import SwiftUI

    struct InputView: View {
        @Binding var text : String
        var title : String
        var placeholder : String
        var secureField : Bool = false
        var body: some View {
            VStack(alignment: .leading , spacing: 12) {
                Text(title)
                    .foregroundColor(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                if secureField {
                    SecureField(placeholder , text: $text)
                      
                        .font(.system(size:14))
                    
                } else {
                    TextField(placeholder , text: $text)
                }
                Divider()
            }
        }
    }

    struct InputView_Previews: PreviewProvider {
        static var previews: some View {
            InputView(text: .constant(""), title: "Email Adress", placeholder: "sarper@example.com")
        }
    }
