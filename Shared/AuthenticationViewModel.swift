//
//  AuthenticationViewModel.swift
//  CleanUV
//
//  Created by user212124 on 5/20/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    
    private let authenticationRepository: AuthenticationRepository

    init(authenticationRepository: AuthenticationRepository =
         AuthenticationRepository()){
            self.authenticationRepository = authenticationRepository
        }
    
    func createNewUser(email: String, password: String) {
        authenticationRepository.createNewUser(email: email, password: password) { [
        weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newUser): self.user = newUser
            case .failure(let error): self.messageError =
                error.localizedDescription
            }
        }
    }
    
    func getCurrentUSer(){
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func logout(){
        do{
            try authenticationRepository.logout()
            self.user = nil
        } catch {
            print("There was a problem while logging out")
        }
    }
    
    func login(email: String, password: String) {
        authenticationRepository.login(email: email, password: password) { [
        weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newUser): self.user = newUser
            case .failure(let error): self.messageError =
                error.localizedDescription
            }
        }
    }
}
