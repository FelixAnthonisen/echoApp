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




var bedpressQuery = """
*[_type == "happening" && happeningType == "BEDPRES"]{
  _id, title, date, companyLink
  "desc": body.no,
  "slug": slug.current,
  "logo": logo.asset._ref
}
"""
// companyLink
// logo


struct Bedpress: Decodable {
    static let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    static let queryAll = client.query([Bedpress].self, query: happeningQuery)
    static let queryListen = client.query(Bedpress.self, query: happeningQuery)
    
    let _id: String
    let title: String
    let date: String
    let desc: String
    let slug: String
    let companyLink: String
    let logo: String
    
    func merge(with: Self) -> Bedpress {
        Bedpress(
            _id: with._id,
            title: with.title,
            date: with.date,
            desc: with.desc,
            slug: with.slug,
            companyLink: with.companyLink,
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
                    self.error = error
                }
            }, receiveValue: { response in
                self.bedpresser = response.result
                self.ms = response.ms
                self.queryString = response.query
            })
    }
    
    func listenHappenings() {
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
}

