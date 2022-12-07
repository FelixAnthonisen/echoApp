//
//  EventInfoBox.swift
//  echoApp
//
//  Created by Torger Bocianowski on 07/12/2022.
//

import SwiftUI

struct InfoBox: View {
    let date: String
    let registrationDate: String
    let location: String
    let contactEmail: String

    
    var body: some View {
        Grid(alignment: .leading,
             horizontalSpacing: 1,
             verticalSpacing: 5) {
            GridRow {
                let start = date.startIndex
                let end = date.index(start, offsetBy: 10)
                let date = String(date[start ..< end])
                VStack (alignment: .leading) {
                    Text("Dato:")
                        .padding(.bottom, 2)
                    HStack {
                        Text(date)
                        Image(systemName: "clock")
                    }
                }
                
                
                let startRegDate = registrationDate.startIndex
                let endRegDate = registrationDate.index(startRegDate, offsetBy: 10)
                let registrationDate = String(registrationDate[startRegDate ..< endRegDate])
                VStack (alignment: .leading) {
                    Text("Påmeldingsdato:")
                        .padding(.bottom, 2)
                    HStack {
                        Text(registrationDate)
                        Image(systemName: "calendar.badge.clock")
                    }
                }
            }
            .padding()
            
            GridRow {
                HStack {
                    Text(location).frame(width: 100).multilineTextAlignment(.leading)
                    Image(systemName: "mappin.and.ellipse")
                }
                
                
                Link(destination: URL(string: contactEmail)!) {
                    Text("Avmelding")
                        .underline()
                    Image(systemName: "arrow.up.forward.square")
                }
                
            }
            .padding()
            
        }
        .padding()
        .background(Util.lightGradient())
        .foregroundColor(.white)
        .bold()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 0.5)
        )
    }
}

struct InfoBox_Previews: PreviewProvider {
    static var previews: some View {
        InfoBox(
            date: "2022-69-11",
            registrationDate: "2022-42-24",
            location: "hos meg veien en to tre langt",
            contactEmail: "torgerboc@gmail.com"
        )
    }
}
