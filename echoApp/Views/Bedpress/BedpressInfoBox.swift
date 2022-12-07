//
//  EventInfoBox.swift
//  echoApp
//
//  Created by Torger Bocianowski on 03/12/2022.
//

import SwiftUI

struct BedpressInfoBox: View {
    let date: String
    let registrationDate: String
    let location: String
    let contactEmail: String

    
    var body: some View {
        VStack {
            HStack {
                
                let start = date.startIndex
                let end = date.index(start, offsetBy: 10)
                Text(date[start..<end])
                    .padding()
                
                let start1 = registrationDate.startIndex
                let end1 = registrationDate.index(start1, offsetBy: 10)
                Text(registrationDate[start1..<end1])
                    .padding()
            }
            
            
            HStack {
                Spacer()
                Text(location)
                Spacer()
                Link(destination: URL(string: contactEmail)!) {
                    Text("Avmelding")
                }
                Spacer()
            }
            
        }
    }
}


