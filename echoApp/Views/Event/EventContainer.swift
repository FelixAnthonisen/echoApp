//
//  EventContainer.swift
//  echoApp
//
//  Created by Felix Anthonisen on 04/12/2022.
//

import SwiftUI

struct EventContainer: View {
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    let title: String
    
    @ObservedObject private var eventFetcher = EventFetcher()
    
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
                    EventList(events: self.eventFetcher.events)
                }
                .onAppear {
                    self.eventFetcher.fetchEvents()
                    self.eventFetcher.listenEvents()
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
    let slug: String
    
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

struct EventList: View {
    let events: [Event]
    
    var body: some View {
        VStack {
            ForEach(self.events, id: \._id) { event in
                VStack (alignment: .leading) {
                    NavigationLink(destination: {
                        EventView(title: event.title,
                                  date: event.date,
                                  desc: event.desc,
                                  slug: event.slug
                        )
                    }) {
                        HStack {
                            Text(event.title)
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
