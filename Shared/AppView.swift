//
//  AppView.swift
//  CleanUV
//
//  Created by user212124 on 5/27/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    var bluetooth = Bluetooth.shared
    @State var presented: Bool = false
    @State var list = [Bluetooth.Device]()
    @State var isConnected: Bool = Bluetooth.shared.current != nil {
        didSet{
            if isConnected {presented.toggle()}
        }
    }
    
    var body: some View {
        ZStack {
            
            Image("fondo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack{
                
                Text("iCleanUV")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                Text("Remote Control")
                    .font(.caption)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                HStack{
                    Button {
                        print("Holi")
                    } label: {
                        Image("onoff")
                            .resizable()
                            .frame(width: 65.0, height: 65.0)
                    }
                    .padding(.trailing, 10.0)
                    
                    Button {
                        print("Holi")
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
                    print("FORWARD")
                } label: {
                    Image("moveButton")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                        .rotationEffect(.degrees(270))
                }
                HStack{
                    Spacer()
                    Button {
                        print("RIGHT")
                    } label: {
                        Image("moveButton")
                            .resizable()
                            .frame(width: 100.0, height: 100.0)
                            .rotationEffect(.degrees(180))
                    }
                    .padding(.trailing, 30.0)
                    
                    
                    Button {
                        print("LEFT")
                    } label: {
                        Image("moveButton")
                            .resizable()
                            .frame(width: 100.0, height: 100.0)
                    }
                    .padding(.leading, 30.0)
                    Spacer()
                }
                
                Button {
                    print("BACK")
                } label: {
                    Image("moveButton")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                        .rotationEffect(.degrees(90))
                }
                Spacer()
            }
        
            
        }
        
            
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
