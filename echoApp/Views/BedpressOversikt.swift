//
//  Bedpress.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI
import Foundation

struct BedpressOversikt: View {
    let bedpresser = [
        "NBIM": "20. des",
        "Bouvet": "10. nov",
        "DNB": "31. okt",
        "Visma": "4. jun",
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
            NavigationStack {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    ScrollView {
                        ForEach(bedpresser.sorted(by: <), id: \.key) { name, date in
                            NavigationLink(destination: BedpressView(text: name)) {
                                HStack {
                                    Text(name)
                                    Spacer()
                                    Text(date)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 8)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct BedpressOversikt_Previews: PreviewProvider {
    static var previews: some View {
        BedpressOversikt().background(.black)
    }
}

struct BedpressView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(.red)
    }
}
