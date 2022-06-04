//
//  AthenticationFirebaseDataSource.swift
//  CleanUV
//
//  Created by user212124 on 5/20/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User{
    let email: String
}

final class AuthenticationFirebaseDataSource{
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){
            authDataResult, error in
            
            if let error = error {
                print("There was a problem while creating a new user: \(error.localizedDescription)" )
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            print("New user was created with info: \(email)")
            completionBlock(.success(.init(email: email)))
    }
}
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(email: email)
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){
            authDataResult, error in
            
            if let error = error {
                print("There was a problem while log in: \(error.localizedDescription)" )
                completionBlock(.failure(error))
                return
                
            }
            
            let email = authDataResult?.user.email ?? "No email"
            print("New user was created with info: \(email)")
            completionBlock(.success(.init(email: email)))
            
        }
    }
    
    func logout() throws{
        try Auth.auth().signOut()
    }
}
