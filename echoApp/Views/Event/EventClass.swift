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
*[_type == "happening" && happeningType == "EVENT" && registrationDate != NULL && slug.current != NULL] {
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
    let location: String
    let registrationDate: String
    let desc: String
    let slug: String
    
    func merge(with: Self) -> Event {
        Event(
            _id: with._id,
            title: with.title,
            date: with.date,
            location: with.location,
            registrationDate: with.registrationDate,
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
    
    func createDateFromIso(isoStr: String) -> Date {
        let start: String.Index = isoStr.startIndex
        let end: String.Index = isoStr.index(start, offsetBy: 10)
        return Date(String(isoStr[start..<end]))
    }
    
    func bubbleSort(arr: [Event], minSorted: Bool) -> [Event] {
        let n: Int = arr.count
        var newArr: [Event] = arr
        for i in 0..<n{
            for j in 0..<(n-i-1){
                let d1: Date = createDateFromIso(isoStr: newArr[j].date)
                let d2: Date = createDateFromIso(isoStr: newArr[j+1].date)
                if (d1 > d2 && minSorted){
                    newArr.swapAt(j, j+1)
                }
                else if (d1 < d2 && !minSorted){
                    newArr.swapAt(j, j+1)
                }
            }
        }
        return newArr
    }
    func sortAndDivide() -> [[Event]]{
        var previous: [Event] = []
        var upcoming: [Event] = []
        for i in 0..<events.count{
            let eventDate: Date = createDateFromIso(isoStr: events[i].date)
            if (eventDate >= Date.now){
                upcoming.append(events[i])
            }
            else{
                previous.append(events[i])
            }
        }
        return [bubbleSort(arr: previous, minSorted: false), bubbleSort(arr: upcoming, minSorted: true)]
    }
}
