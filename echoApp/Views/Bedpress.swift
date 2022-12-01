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
        "DNB",
        "Visma",
        "blabla",
        "enda en",
        "yes"
    ]
    
    var body: some View {
        VStack {
            
            Text("Bedpresser")
                .fontWeight(.bold)
                .font(Font.system(size: 25))
                .foregroundColor(.white)
                .padding()
            Divider()
                .overlay(.white)
                .padding(.bottom)
            ForEach(bedpresser, id:\.self) { bedpress in
                HStack {
                    Text(bedpress)
                        .listRowBackground(Color.black.opacity(0))
                    .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.bottom, 8)
            }
        }
    }
}

struct Bedpress_Previews: PreviewProvider {
    static var previews: some View {
        Bedpress().background(.black)
    }
}
