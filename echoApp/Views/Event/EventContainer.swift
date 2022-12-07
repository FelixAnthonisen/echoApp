//
//  EventContainer.swift
//  echoApp
//
//  Created by Felix Anthonisen on 04/12/2022.
//

import SwiftUI


struct EventContainer: View {

    let title: String
    @State private var eventExpanded = false
    @ObservedObject private var eventFetcher = EventFetcher()
    
    var body: some View {
        Button(action: {
            self.eventExpanded.toggle()
        }){
            VStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Divider()
                    .overlay(.white)
                    .padding(.bottom)
                EventList(events: self.eventFetcher.sortAndDivide()[0])
                    .onAppear {
                        self.eventFetcher.fetchEvents()
                        self.eventFetcher.listenEvents()
                    }
            }
            .background(Util.lightGradient())
        }
        .cornerRadius(20)
        .padding(.bottom)
        .sheet(isPresented: $eventExpanded){
            ExpandedEvent(eventFetcher: self.eventFetcher)
        }
    }
}

struct ExpandedEvent: View {
    @ObservedObject var eventFetcher: EventFetcher
    var body: some View {
        NavigationStack {
            VStack {
                Text("Arrangementer")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Divider()
                    .overlay(.white)
                ScrollView {
                    ForEach(eventFetcher.sortAndDivide()[0], id: \._id) { event in
                        NavigationLink(destination: {
                         EventView(
                             _id: event._id,
                             title: event.title,
                             date: event.date,
                             registrationDate: event.registrationDate,
                             location: event.location,
                             desc: event.desc,
                             slug: event.slug
                         )
                        }){
                            HStack {
                                Text(event.title)
                                    .font(.title3)
                                Spacer()
                                let start = event.date.startIndex
                                let end = event.date.index(start, offsetBy: 10)
                                Text(event.date[start..<end])
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

struct EventView: View {
    
    let _id: String
    let title: String
    let date: String
    let registrationDate: String
    let location: String
    let desc: String
    let slug: String
    
    var body: some View {
        ScrollView(.vertical) {
            HStack {
                VStack {
                    Link(destination: URL(string: "https://echo.uib.no/event/\(slug)")!) {
                        Text(title)
                            .font(.title)
                            .bold()
                            .padding()
                    }
                    LinkButton(slug: slug, label: "Til påmelding")
                }
                .padding()
            }
            .padding()
            
            InfoBox(date: self.date,
                    registrationDate: self.registrationDate,
                    location: self.location,
                    contactEmail: "example@gmail.com"
            )

            VStack (alignment: .leading) {
                Text("Mer om arrangementet:")
                    .font(.title3)
                    .bold()
                    .padding()
                Text(desc)
                    .multilineTextAlignment(.leading)
                    .padding(20)
            }
            
            .background(Util.lightGradient())
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 0.5)
        )
            .padding(25)
        }
        .foregroundColor(.white)
        .background(Util.gradient())
        
    }
}

struct EventList: View {
    let events: [Event]
    
    var body: some View {
        VStack{
            let slice = self.events.count > 3 ? Array(self.events[...3]) : self.events
            ForEach(slice, id: \._id) { event in
                HStack {
                    Text(event.title)
                        .multilineTextAlignment(.leading)
                        .font(.title3)
                    Spacer()
                    let start = event.date.startIndex
                    let end = event.date.index(start, offsetBy: 10)
                    Text(event.date[start..<end])
                }
                .foregroundColor(.white)
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
            }
        }
    }
}
