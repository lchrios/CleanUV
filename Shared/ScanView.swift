//
//  ScanView.swift
//  CleanUV
//
//  Created by Christopher Ortega on 03/06/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import SwiftUI

struct ScanView: View {
    var bluetooh: Bluetooth
    
    @Binding var presented: Bool
    @Binding var list: [Bluetooth.Device]
    @Binding var isConnected: Bool
    
    var body: some View {
        HStack{
            Spacer()
            if isConnected {
                Text("conectado a \(bluetooh.current?.name ?? "")")
            }
            Spacer()
            
            Button(action: {presented.toggle()}){
                Color(UIColor.secondarySystemBackground).overlay(Image(systemName: "multiply").foregroundColor(Color(UIColor.systemGray))).frame(width: 30, height: 30).cornerRadius(15)
            }.padding([.horizontal, .top]).padding(.bottom, 8)
        }
        if isConnected {
            HStack{
                Button("Desconectar"){bluetooh.disconnect()}
                .buttonStyle(appButton()).padding(.horizontal)
                Spacer()
            }
        }
        List(list){ peripheral in
            Button(action: {bluetooh.Connect(peripheral.peripheral)}){
                HStack{
                    Text(peripheral.peripheral.name ?? "").fontWeight(.bold)
                        Spacer()
                }
                HStack{
                    Text(peripheral.uuid).font(.system(size: 10)).foregroundColor(.black)
                    Spacer()
                    
                }
            }
            
        }.listStyle(InsetGroupedListStyle()).onAppear{(bluetooh.StartScanning())}.onDisappear(){
            bluetooh.StopScanning()
        }
        .padding(.vertical,0)
    }
}

