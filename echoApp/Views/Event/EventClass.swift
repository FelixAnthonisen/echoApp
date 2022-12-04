//
//  Test.swift
//  echoApp
//
//  Created by Torger Bocianowski on 02/12/2022.
//

import SwiftUI
import Sanity
import Foundation
import Combine
import SDWebImageSwiftUI


var eventQuery = """
*[_type == "happening" && happeningType == "EVENT"] {
  _id, title, date, location, registrationDate, 
  "desc": body.no,
  "slug": slug.current
}
"""

// companyLink
// logo


struct Event: Decodable {
    static let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    static let queryAll = client.query([Event].self, query: eventQuery)
    static let queryListen = client.query(Event.self, query: eventQuery)
    
    let _id: String
    let title: String
    let date: String
    let desc: String
    let slug: String
    
    func merge(with: Self) -> Event {
        Event(
            _id: with._id,
            title: with.title,
            date: with.date,
            desc: with.desc,
            slug: with.slug
        )
    }
}

class EventFetcher: ObservableObject {
    @Published var events: [Event] = []
    @Published var error: Error? = nil
    @Published var ms: Int = 0
    @Published var queryString: String = ""

    private var fetchEventsCancellable: AnyCancellable?
    private var listenEventsCancellable: AnyCancellable?

    func fetchEvents() {
        fetchEventsCancellable?.cancel()
        fetchEventsCancellable = Event.queryAll.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.error = error
                }
            }, receiveValue: { response in
                self.events = response.result
                self.ms = response.ms
                self.queryString = response.query
            })
    }
    
    func listenEvents() {
        listenEventsCancellable?.cancel()
        listenEventsCancellable = Event.queryListen.listen()
            .receive(on: DispatchQueue.main)
            .sink { update in
                guard let event = update.result else {
                    return
                }
                if let index = self.events.firstIndex(where: { $0._id == event._id }) {
                    self.events[index] = self.events[index].merge(with: event)
                }
            }
        }
    
    func cancel() {
        fetchEventsCancellable?.cancel()
        listenEventsCancellable?.cancel()
    }
}
