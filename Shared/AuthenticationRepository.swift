//
//  AuthenticationRepository.swift
//  CleanUV
//
//  Created by user212124 on 5/20/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//
import Foundation

final class AuthenticationRepository{
    private let authenticationFirebaseDataSource:
        AuthenticationFirebaseDataSource
    
    init(authenticationFirebaseDataSource:
         AuthenticationFirebaseDataSource =
         AuthenticationFirebaseDataSource()){
        self.authenticationFirebaseDataSource =
            authenticationFirebaseDataSource
    }
    
    func createNewUser(email: String, password: String,
        completionBlock: @escaping (Result<User, Error>) -> Void){
            authenticationFirebaseDataSource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    
    func getCurrentUser() -> User? {
        authenticationFirebaseDataSource.getCurrentUser()
    }
    
    func logout() throws{
        try authenticationFirebaseDataSource.logout()
    }
    
    func login (email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        authenticationFirebaseDataSource.login (email: email, password: password, completionBlock: completionBlock)
    }
    
}
