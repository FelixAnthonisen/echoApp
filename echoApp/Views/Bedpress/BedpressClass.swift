//
//  BedpressClass.swift
//  echoApp
//
//  Created by Torger Bocianowski on 03/12/2022.
//

import SwiftUI
import Sanity
import Foundation
import Combine
import SDWebImageSwiftUI


// https://stackoverflow.com/questions/24089999/how-do-you-create-a-swift-date-object
extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

var bedpressQuery = """
*[_type == "happening" && happeningType == "BEDPRES" && registrationDate != NULL && slug.current != NULL]{
    _id, title, date, companyLink, registrationDate,
    location,
    "desc": body.no,
    "slug": slug.current,
    logo
}
"""

struct Bedpress: Decodable {
    static let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    static let queryAll = client.query([Bedpress].self, query: bedpressQuery)
    static let queryListen = client.query(Bedpress.self, query: bedpressQuery)
    
    let _id: String
    let title: String
    let date: String
    let companyLink: String
    let registrationDate: String
    let location: String
    let desc: String
    let slug: String
    let logo: SanityType.Image

    func merge(with: Self) -> Bedpress {
        Bedpress(
            _id: with._id,
            title: with.title,
            date: with.date,
            companyLink: with.companyLink,
            registrationDate: with.registrationDate,
            location: with.location,
            desc: with.desc,
            slug: with.slug,
            logo: with.logo
        )
    }
}

class BedpressFetcher: ObservableObject {
    @Published var bedpresser: [Bedpress] = []
    @Published var error: Error? = nil
    @Published var ms: Int = 0
    @Published var queryString: String = ""

    private var fetchBedpresserCancellable: AnyCancellable?
    private var listenBedpresserCancellable: AnyCancellable?

    func fetchBedpresser() {
        fetchBedpresserCancellable?.cancel()
        fetchBedpresserCancellable = Bedpress.queryAll.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error)
                    self.error = error
                }
            }, receiveValue: { response in
                self.bedpresser = response.result
                self.ms = response.ms
                self.queryString = response.query
            })
    }
    
    func listenBedpresser() {
        listenBedpresserCancellable?.cancel()
        listenBedpresserCancellable = Bedpress.queryListen.listen()
            .receive(on: DispatchQueue.main)
            .sink { update in
                guard let bedpress = update.result else {
                    return
                }
                if let index = self.bedpresser.firstIndex(where: { $0._id == bedpress._id }) {
                    self.bedpresser[index] = self.bedpresser[index].merge(with: bedpress)
                }
            }
        }
    
    func cancel() {
        fetchBedpresserCancellable?.cancel()
        listenBedpresserCancellable?.cancel()
    }

    func sortAndDivide() -> [[Bedpress]]{
        var previous: [Bedpress] = []
        var upcoming: [Bedpress] = []
        for i in 0..<bedpresser.count{
            
            let dateStr: String = bedpresser[i].date
            
            let start: String.Index = dateStr.startIndex
            let end: String.Index = dateStr.index(start, offsetBy: 10)
            let bedpressDate: Date = Date(String(dateStr[start..<end]))
            
            if (bedpressDate >= Date.now){
                upcoming.append(bedpresser[i])
            }
            else{
                previous.append(bedpresser[i])
            }
        }
        return [previous, upcoming]
    }
}

