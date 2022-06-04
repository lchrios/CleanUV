//
//  ContentView.swift
//  Shared
//
//  Created by user212124 on 5/20/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authenticationViewModel:
        AuthenticationViewModel
    
    var bluetooth = Bluetooth.shared
    @State var presented: Bool = false
    @State var list = [Bluetooth.Device]()
    @State var isConnected: Bool = Bluetooth.shared.current != nil {
        didSet{
            if isConnected {presented.toggle()}
        }
    }
    @State var reponse = Data()
    @State var string: String = ""
    @State var value: String = ""
    @State var state: Bool = false { didSet { bluetooth.send([UInt8(state.int)])}
    }
    @State var editing = false
    
    var body: some View {
        NavigationView{
            ZStack {
                
                Image("fondo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack{
                    /*Text("Welcome  \(authenticationViewModel.user?.email ?? "No email")")
                    .padding(.top, 32)
                Spacer()*/
            
                    Text("iCleanUV")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                    
                    Text("Remote Control")
                        .font(.caption)
                        .foregroundColor(Color.white)
                    Button("Buscar dispositivos"){presented.toggle()}
                        .buttonStyle(appButton()).padding()
                    Spacer()
                    if isConnected {
                        Button("Desconectar") {bluetooth.disconnect()}
                            .buttonStyle(appButton()).padding()
                    }
                    if isConnected {
                        HStack{
                            Button {
                                sendValue("Holi")
                            } label: {
                                Image("onoff")
                                    .resizable()
                                    .frame(width: 65.0, height: 65.0)
                            }
                            .padding(.trailing, 10.0)
                            
                            Button {
                                presented.toggle()
                            } label: {
                                Image("bt")
                                    .resizable()
                                    .frame(width: 65.0, height: 65.0)
                            }
                            
                        }
                        .padding(.leading, 10.0)
                        Spacer()
                        Spacer()
                        Button {
                            sendValue("FORWARD")
                        } label: {
                            Image("moveButton")
                                .resizable()
                                .frame(width: 100.0, height: 100.0)
                                .rotationEffect(.degrees(270))
                        }
                        HStack{
                            Spacer()
                            Button {
                                sendValue("RIGHT")
                            } label: {
                                Image("moveButton")
                                    .resizable()
                                    .frame(width: 100.0, height: 100.0)
                                    .rotationEffect(.degrees(180))
                            }
                            .padding(.trailing, 30.0)
                            
                            
                            Button {
                                sendValue("LEFT")
                            } label: {
                                Image("moveButton")
                                    .resizable()
                                    .frame(width: 100.0, height: 100.0)
                            }
                            .padding(.leading, 30.0)
                            Spacer()
                        }
                        
                        Button {
                            sendValue("BACK")
                        } label: {
                            Image("moveButton")
                                .resizable()
                                .frame(width: 100.0, height: 100.0)
                                .rotationEffect(.degrees(90))
                        }
                        Spacer()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")
                .toolbar{
                    Button("Logout"){
                        authenticationViewModel.logout()
                    }
                }
                .sheet(isPresented: $presented){
                    ScanView(bluetooh: bluetooth, presented: $presented, list: $list, isConnected: $isConnected) }
                .onAppear{bluetooth.delegate = self}
            }
        }
    }
    
    func sendValue(_ value: String){
        if value.utf8 != self.value.utf8 {
            guard let sendValue
                    : [UInt8] = Array(value.utf8)
            bluetooth.send(sendValue)
        }
        self.value = value
    }
}

extension ContentView: BluetoothProtocol {
    func Value(data: Data) {
        reponse = data
    }
    
    func state(state: Bluetooth.State) {
        switch state {
        case .unknown: print("unknown")
        case .resetting: print("resetting")
        case .unsupported: print("unsupported")
        case .unauthorized: print("unauthorized")
        case .poweroff: print("poweroff")
        case .powerOn: print("powerOn")
        case .connected: isConnected = true
        case .disconnected: isConnected = false
        case .error : print("Tamos mal uwu")
        }
    }
    
    func list(list: [Bluetooth.Device]){
        self.list = list
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authenticationViewModel:
        AuthenticationViewModel())
    }
}
