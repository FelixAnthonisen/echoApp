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
    let logo: SanityType.Image
    var body: some View {
        WebImage(url: client.imageURL(self.logo)
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
    @State private var bedpressExpanded = false
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    let title: String
    @ObservedObject private var bedpressFetcher = BedpressFetcher()
    
    var body: some View {
        Button(action: {bedpressExpanded.toggle()}) {
            VStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Divider()
                    .overlay(.yellow)
                    .padding(.bottom)
                BedpressList(bedpresser: self.bedpressFetcher.sortAndDivide()[0])
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
        .sheet(isPresented: $bedpressExpanded){
            ExpandedBedpress(bedpressFetcher: bedpressFetcher)
        }
    }
}
struct ExpandedBedpress: View {
    @ObservedObject var bedpressFetcher: BedpressFetcher
    var body: some View {
        NavigationStack{
            VStack{
                Text("Bedpresser")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Divider()
                    .overlay(.white)
                ScrollView {
                    ForEach(bedpressFetcher.sortAndDivide()[0], id: \._id) { bedpress in
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
                        }){
                            HStack {
                                CircleImage(logo: bedpress.logo)
                                Text(bedpress.title)
                                    .font(.title3)
                                Spacer()
                                let start = bedpress.date.startIndex
                                let end = bedpress.date.index(start, offsetBy: 10)
                                Text(bedpress.date[start..<end])
                            }
                            .foregroundColor(.white)
                            .padding(.vertical)
                        }
                    }
                }
            }
            .padding(20)
            .background(Util.gradient())
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
    let logo: SanityType.Image
    
    var body: some View {
        VStack {
            CircleImage(logo: self.logo)
            Link(destination: URL(string: "https://echo.uib.no/event/\(slug.replacingOccurrences(of: " ", with: "%20"))")!){
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


/**NavigationLink(destination: {
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
}) */
struct BedpressList: View {
    let bedpresser: [Bedpress]
    
    var body: some View {
        VStack {
            let slice = self.bedpresser.count > 3 ? Array(self.bedpresser[...3]) : self.bedpresser
            ForEach(slice, id: \._id) { bedpress in
                HStack {
                    CircleImage(logo: bedpress.logo)
                    Text(bedpress.title)
                        .font(.title3)
                    Spacer()
                    let start = bedpress.date.startIndex
                    let end = bedpress.date.index(start, offsetBy: 10)
                    Text(bedpress.date[start..<end])
                }
            }
        }
        .foregroundColor(.white)
        .padding(.bottom, 10)
        .padding(.horizontal, 10)
    }
}
    
    
