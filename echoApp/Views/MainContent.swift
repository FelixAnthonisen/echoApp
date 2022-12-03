//
//  MainContent.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct MainContent: View {
    //@State private var bedpressPresented:Bool = false
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack {
            InfoContainer(title: "Arrangementer")
            InfoContainer(title: "Bedpresser")
            /*Button(action: {self.bedpressPresented.toggle()}) {InfoContainer(title: "Arrangementer", data: happenings)
            }
            .sheet(isPresented: $bedpressPresented){
                InfoContainer(title: "Arrangementer", data: happenings)
                    .background(.black)
            }*/

        }
        .padding(.horizontal, 20)
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainContent()
    }
}


struct InfoContainer: View {
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    let title: String
    //let data: [String: String]
    
    
    @ObservedObject private var happeningFetcher = HappeningFetcher()
    
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
                    HappeningList(happenings: self.happeningFetcher.happenings)
                }
                .onAppear {
                    self.happeningFetcher.fetchHappenings()
                    self.happeningFetcher.listenHappenings()
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
    
struct EventView: View {
    //let _id: String
    let title: String
    let date: String
    let desc: String
    //let slug: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .padding()

            let start = date.startIndex
            let end = date.index(start, offsetBy: 10)
            Text(date[start..<end])
                .font(.title2)
                .foregroundColor(.white)
                .padding()
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

struct HappeningList: View {
    let happenings: [Happening]
    
    var body: some View {
        VStack {
            ForEach(self.happenings, id: \._id) { happening in
                VStack {
                    NavigationLink(destination: {
                        EventView(title: happening.title, date: happening.date, desc: happening.desc)
                    }) {
                        HStack {
                            Text(happening.title)
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
    
    

