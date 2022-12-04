//
//  BedpressContainer.swift
//  echoApp
//
//  Created by Felix Anthonisen on 04/12/2022.
//

import SwiftUI
import Sanity
import SDWebImageSwiftUI


struct CircleImage: View{
    let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    let image: SanityType.Image
    init(ref: String){
        self.image = SanityType.Image(
            asset: SanityType.Ref(
                _ref: ref,
                _type: "reference"
            ),
            crop: SanityType.Image.Crop(
                bottom: 0.1,
                left: 0.1,
                top: 0.1,
                right: 0.1
            ),
            hotspot: SanityType.Image.Hotspot(
                width: 0.3,
                height: 0.3,
                x: 0.3,
                y: 0.3
            )
        )
    }
    var body: some View {
        WebImage(url: client.imageURL(self.image)
            .URL()
        )
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40, alignment: .center)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.white, lineWidth: 1)
        }
    }
}

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
    let location: String
    let desc: String
    let slug: String
    let logo: String
    
    var body: some View {
        VStack {
            CircleImage(ref: logo)
            Link(destination: URL(string: "https://echo.uib.no/event/\(slug.replacingOccurrences(of: " ", with: "", options: .literal, range: nil))")!){
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
            Image(systemName: "profile")
            ForEach(self.bedpresser, id: \._id) { bedpress in
                VStack (alignment: .leading) {
                    NavigationLink(destination: {
                        BedpressView(
                            _id: bedpress._id,
                            title: bedpress.title,
                            date: bedpress.date,
                            companyLink: bedpress.companyLink,
                            registrationDate: bedpress.registrationDate,
                            location: bedpress.location,
                            desc: bedpress.desc,
                            slug: bedpress.slug,
                            logo: bedpress.logo
                        )
                    }) {
                        HStack {
                            CircleImage(ref: bedpress.logo)
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
    
    
