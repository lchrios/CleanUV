//
//  LoginEmailView.swift
//  CleanUV
//
//  Created by user212124 on 5/22/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import SwiftUI

struct LoginEmailView: View {
        @ObservedObject var authenticationViewModel:
            AuthenticationViewModel
        @State var textFieldEmail: String = ""
        @State var textFieldPassword: String = ""
        
        init(authenticationViewModel: AuthenticationViewModel){
            self.authenticationViewModel = authenticationViewModel
        }
        
        var body: some View {
            VStack{
                DiscardView()
                    .padding(.top, 8)
                Group{
                    Text("Welcome to")
                    Text("I clean app")
                    Text("Feel free to login")
                        .bold()
                        .underline()
                }
                .padding(.horizontal, 8)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .tint(.primary)
                
                Group{
                    Text("Login to obtain more information")
                }
                .tint(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top, 2)
                .padding(.bottom, 32)
                
                TextField("Enter your email", text: $textFieldEmail)
                TextField("Enter your password", text: $textFieldPassword)
                Button("Continue"){
                    authenticationViewModel.login(email: textFieldEmail, password: textFieldPassword)
                }
                .padding(.top, 18)
                .buttonStyle(.bordered)
                .tint(.blue)

                if let messageError = authenticationViewModel.messageError
                {
                    Text(messageError)
                        .bold()
                        .font(.body)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 64)
            Spacer()
        }
}
