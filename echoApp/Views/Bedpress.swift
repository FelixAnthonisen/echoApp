//
//  Bedpress.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI
import Foundation

struct Bedpress: View {
    
    let bedpresser = [
        "NBIM",
        "Bouvet",
        "DNB"
    ]
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Bedriftspresentasjoner")
                    .font(Font.system(size: 25))
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            
            
            List {
                ForEach(bedpresser, id:\.self) { bedpress in
                    Text(bedpress)
                        .listRowBackground(Color.black.opacity(0))
                        .foregroundColor(.white)
                }
            }.listStyle(.plain)
        }.background(Color.black)
    }
}

struct Bedpress_Previews: PreviewProvider {
    static var previews: some View {
        Bedpress()
    }
}
