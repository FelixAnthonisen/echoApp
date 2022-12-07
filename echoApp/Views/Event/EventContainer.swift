//
//  EventContainer.swift
//  echoApp
//
//  Created by Felix Anthonisen on 04/12/2022.
//

import SwiftUI
let backgroundGradient = LinearGradient(
    colors: [Color("GradientStart"), Color("GradientEnd")],
    startPoint: .top, endPoint: .bottom)
struct EventContainer: View {
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    
    let title: String
    @State private var eventExpanded = false
    @ObservedObject private var eventFetcher = EventFetcher()
    
    
    var body: some View {
        Button(action: {eventExpanded.toggle()}){
            VStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Divider()
                    .overlay(.yellow)
                    .padding(.bottom)
                EventList(events: self.eventFetcher.sortAndDivide()[0])
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
        }
        .sheet(isPresented: $eventExpanded){
            ExpandedEvent(eventFetcher: self.eventFetcher)
        }
    }
}

struct ExpandedEvent: View {
    @ObservedObject var eventFetcher: EventFetcher
    var body: some View {
        NavigationStack{
            VStack{
                Text("Arrangementer")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Divider()
                    .overlay(.white)
                ScrollView {
                    ForEach(eventFetcher.sortAndDivide()[0], id: \._id) { event in
                        NavigationLink(destination: {
                            EventView(title: event.title,
                                      date: event.date,
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
    //let _id: String
    let title: String
    let date: String
    let desc: String
    let slug: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .padding()

            let start = date.startIndex
            
            let end = date.index(start, offsetBy: 10)
            
            HStack {
                Text(date[start..<end])
                    .font(.title3)
                .foregroundColor(.white)
                Spacer()
                Link(destination: URL(string: "https://echo.uib.no/event/\(slug)")!){
                    Button (action: {
                        // bare for å komme til linken og ha riktig styling
                    }) {
                        Text("Påmelding")
                            .foregroundColor(.black)
                            .font(.title2)
                            .bold()
                    }
                    .padding([.horizontal], 20)
                    .padding([.vertical], 10)
                    .background(.teal)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                
            }.padding()
            Divider()
                .overlay(.white)
                .padding(.bottom)
            ScrollView {
                Text(desc)
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
        }
        .background(backgroundGradient)
        
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
