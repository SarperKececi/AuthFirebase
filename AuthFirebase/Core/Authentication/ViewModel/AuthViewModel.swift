//
//  AuthViewModel.swift
//  AuthFirebase
//
//  Created by Sarper Kececi on 25.12.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
protocol AuhthenticationProtocol {
    var formIsValid : Bool { get }
}
@MainActor
class AuthViewModel : ObservableObject {
    @Published var userSessions : FirebaseAuth.User?
    @Published var currentUser : User?
    
    init() {
        self.userSessions = Auth.auth().currentUser
        Task {
            await fetchUser()   
        }
    }
    
    
    func signIn(withEmail email : String , password : String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSessions = result.user
            await fetchUser()
        } catch {
            print("DEBUG : Failed to sign in with Error\(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, fullName: String, password: String) async throws {
        do {
          let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSessions = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
             let encodedData = try Firestore.Encoder().encode(user)
                    try await Firestore.firestore().collection("Users").document(user.id).setData(encodedData)
        } catch {
            print("DEBUG : Failed to create user with error\(error.localizedDescription)")
        }
    }

    
    func signOut() {
        do {
            try  Auth.auth().signOut()
            self.userSessions = nil
            self.currentUser = nil
        } catch {
            print("HATA: Oturumu kapatma işlemi başarısız oldu. Hata: \(error.localizedDescription)")
        }
    }

    
    func deleteAccount() {
          do {
              // Firebase Authentication'dan kullanıcıyı silme
              try Auth.auth().currentUser?.delete { [weak self] error in
                  guard let self = self else { return }
                  if let error = error {
                      print("HATA: Kullanıcıyı silme işlemi başarısız oldu. Hata: \(error.localizedDescription)")
                  } else {
                      // Kullanıcı başarıyla silindiğinde yapılacak işlemler
                      self.userSessions = nil
                      self.currentUser = nil
                  }
              }
          } catch {
              print("HATA: Kullanıcıyı silme işlemi başarısız oldu. Hata: \(error.localizedDescription)")
          }
      }
    
    func fetchUser() async {
       guard let uuid = Auth.auth().currentUser?.uid else { return }
        guard let snapShot = try? await Firestore.firestore().collection("Users").document(uuid).getDocument() else { return }
        self.currentUser = try? snapShot.data(as: User.self)
        print("CurrentUser\(String(describing: currentUser))")
    }
  
}
// AuthViewModel.swift

