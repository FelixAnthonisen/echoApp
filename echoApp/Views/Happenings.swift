//
//  Happenings.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI

struct Happenings: View {
    
    let happenings = [
        "Julelunsj med Hyggkom🎄",
        "Eksamensfest med Tilde🥳",
        "Vinterball🥂",
        "Bedriftstur til Oslo🏙",
        "Eksamen"
    ]
    
    var body: some View {
        VStack {
            
            Text("Arrangementer")
                .fontWeight(.bold)
                .font(Font.system(size: 25))
                .foregroundColor(.white)
                .padding()
            Divider()
                .overlay(.white)
                .padding(.bottom)
            ForEach(happenings, id:\.self) { happening in
                HStack {
                    Text(happening)
                        .listRowBackground(Color.black.opacity(0))
                    .foregroundColor(.white)
                    Spacer()
                    Text("10. Des")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
            }
        }
    }
}

struct Happenings_Previews: PreviewProvider {
    static var previews: some View {
        Happenings().background(.black)
    }
}
