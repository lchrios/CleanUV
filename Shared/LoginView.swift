//
//  LoginView.swift
//  CleanUV
//
//  Created by user212124 on 5/20/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import SwiftUI

enum AuthenticationSheetView: String, Identifiable {
    case register
    case login
    
    var id: String{
        return rawValue
    }
}


struct LoginView: View {
    @ObservedObject var authenticationViewModel:
        AuthenticationViewModel
    @State private var authenticationSheetView:
        AuthenticationSheetView?
    var body: some View {
        VStack{
            
            Spacer()
            Image("clean3")
            Text("I Clean")
                .font(.system(size:40, weight: .medium, design: .serif))
                .foregroundColor(Color(#colorLiteral(red: 0.30, green: 0.80, blue: 1, alpha: 1 )))
            //Color(.init(red: 0, green: 1, blue: 1, alpha: 1))
            //.edgesIgnoringSafeArea(.all)               // .resizable()
            //Circle()
                //.frame(width: 200, height: 200)
           
            VStack{
                Button("Login with email"){
                    authenticationSheetView = .login
                }
                .tint(.black)
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 60)
            Spacer()
            
            HStack{
                Button{
                    authenticationSheetView = .register
                } label: {
                    Text("No account?")
                    Text("Register")
                        .underline()
                }
                .tint(.black)
            }
        }
        .sheet(item: $authenticationSheetView){ sheet in
            switch sheet {
            case .register:
               EmailRegisterView(authenticationViewModel: authenticationViewModel)
            case .login:
               LoginEmailView(authenticationViewModel:authenticationViewModel)
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authenticationViewModel: AuthenticationViewModel())
    }
}
