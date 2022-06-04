//
//  CleanUVApp.swift
//  Shared
//
//  Created by user212124 on 5/20/22.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        FirebaseApp.configure()
        return true
    }
}

struct appButton: ButtonStyle{
    let color: Color
    
    public init(color: Color = .accentColor ){
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .foregroundColor(.accentColor)
            .background(Color.accentColor.opacity(0.2))
            .opacity(8)
    }
}

@main
struct CleanUVApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.user != nil {
                ContentView(authenticationViewModel: authenticationViewModel)
            }
            else{
                LoginView(authenticationViewModel : authenticationViewModel)
            }
        }
    }
}
