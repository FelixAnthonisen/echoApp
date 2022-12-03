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


var happeningQuery = """
*[_type == "happening"]{
  _id, title, date,
  "desc": body.no,
  "slug": slug.current
}
"""

// companyLink
// logo


struct Happening: Decodable {
    static let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    static let queryAll = client.query([Happening].self, query: happeningQuery)
    static let queryListen = client.query(Happening.self, query: happeningQuery)
    
    let _id: String
    let title: String
    let date: String
    let desc: String
    let slug: String
    
    func merge(with: Self) -> Happening {
        Happening(
            _id: with._id,
            title: with.title,
            date: with.date,
            desc: with.desc,
            slug: with.slug
        )
    }
}

class HappeningFetcher: ObservableObject {
    @Published var happenings: [Happening] = []
    @Published var error: Error? = nil
    @Published var ms: Int = 0
    @Published var queryString: String = ""

    private var fetchHappeningsCancellable: AnyCancellable?
    private var listenHappeningsCancellable: AnyCancellable?

    func fetchHappenings() {
        fetchHappeningsCancellable?.cancel()
        fetchHappeningsCancellable = Happening.queryAll.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.error = error
                }
            }, receiveValue: { response in
                self.happenings = response.result
                self.ms = response.ms
                self.queryString = response.query
            })
    }
    
    func listenHappenings() {
        listenHappeningsCancellable?.cancel()
        listenHappeningsCancellable = Happening.queryListen.listen()
            .receive(on: DispatchQueue.main)
            .sink { update in
                guard let happening = update.result else {
                    return
                }
                if let index = self.happenings.firstIndex(where: { $0._id == happening._id }) {
                    self.happenings[index] = self.happenings[index].merge(with: happening)
                }
            }
        }
    
    func cancel() {
        fetchHappeningsCancellable?.cancel()
        listenHappeningsCancellable?.cancel()
    }
}
