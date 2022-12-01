//
//  Happenings.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI

struct Happenings: View {
    
    let happenings = [
        "NBIM",
        "Bouvet",
        "DNB"
    ]
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Arrangementer")
                    .font(Font.system(size: 25))
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            
            
            List {
                ForEach(happenings, id:\.self) { happening in
                    Text(happening)
                        .listRowBackground(Color.black.opacity(0))
                        .foregroundColor(.white)
                }
            }.listStyle(.plain)
        }.background(Color.black)
    }
}

struct Happenings_Previews: PreviewProvider {
    static var previews: some View {
        Happenings()
    }
}
