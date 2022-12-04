//
//  BedpressContainer.swift
//  echoApp
//
//  Created by Felix Anthonisen on 04/12/2022.
//

import SwiftUI

struct BedpressContainer: View {
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    let title: String
    @ObservedObject private var bedpressFetcher = BedpressFetcher()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Divider()
                    .overlay(.yellow)
                    .padding(.bottom)
                ScrollView {
                    BedpressList(bedpresser: self.bedpressFetcher.bedpresser)
                }
                .onAppear {
                    self.bedpressFetcher.fetchBedpresser()
                    self.bedpressFetcher.listenBedpresser()
                }
                
            }
            .padding(.bottom)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(echoGradient, lineWidth: 0.5)
                )
                .padding(.vertical)
        }
    }
}

struct BedpressView: View {

    let _id: String
    let title: String
    let date: String
    let companyLink: String
    let registrationDate: String
    let registrationDeadline: String
    let location: String
    let desc: String
    let slug: String
    let logo: String
    
    var body: some View {
        VStack {
            Link(destination: URL(string: "https://echo.uib.no/event/\(slug)")!){
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }

            let start = date.startIndex
            let end = date.index(start, offsetBy: 10)
            Text(date[start..<end])
                .font(.title3)
                .foregroundColor(.white)
            ScrollView {
                Text(desc)
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
        }
        .background(.black)
        
    }
}

struct BedpressList: View {
    let bedpresser: [Bedpress]

    var body: some View {
        VStack {
            ForEach(self.bedpresser, id: \._id) { bedpress in
                VStack (alignment: .leading) {
                    NavigationLink(destination: {
                        EventView(title: bedpress.title,
                                  date: bedpress.date,
                                  desc: bedpress.desc,
                                  slug: bedpress.slug
                        )
                    }) {
                        HStack {
                            Text(bedpress.title)
                                .font(.title3)
                            Spacer()
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
            }
        }
    }
}
    
    
