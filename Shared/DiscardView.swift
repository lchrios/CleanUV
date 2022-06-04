//
//  DiscardView.swift
//  CleanUV
//
//  Created by user212124 on 5/22/22.
//  Copyright © 2022 Ingrid. All rights reserved.
//

import SwiftUI

struct DiscardView: View {
    @Environment(\.dismiss) var discard
    var body: some View {
        HStack{
            Spacer()
            Button("Close"){
                discard()
            }
            .tint(.black)
            .padding(.trailing, 12)
        }
        .textFieldStyle(.roundedBorder)
        .buttonStyle(.bordered)
    }
}

struct DiscardView_Previews: PreviewProvider {
    static var previews: some View {
        DiscardView()
    }
}
