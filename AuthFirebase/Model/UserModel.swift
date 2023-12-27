//
//  UserModel.swift
//  AuthFirebase
//
//  Created by Sarper Kececi on 25.12.2023.
//

import Foundation
struct User : Codable{
    var id : String
    var fullName : String
    var email : String
    var initals : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from : fullName) {
            formatter.style = .abbreviated
            return formatter.string(from : components)
        }
        return ""
    }
    
}
extension User {
    static var MOCK_USER = User(id:NSUUID().uuidString , fullName: "Sarper Kececi", email: "sarper@gmail.com")
}
