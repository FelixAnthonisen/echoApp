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
*[_type == "happening"][0...5]{
  _id, title, date,
  "desc": body.no,
  "slug": slug.current
}
"""
struct Test: View {
    @ObservedObject private var happeningFetcher = HappeningFetcher()
    //let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    /*var happeningQuery = """
    *[_type == "happening"][0...5]{
      _id, title, date,
      "desc": body.no,
      "slug": slug.current
    }
    """*/
    /*var bedpressQuery = """
    *[_type == "happening" && happeningType == "BEDPRES"][0...5]{
      _id, title, date,
      "desc": body.no,
      "slug": slug.current
    }
    """*/
    var body: some View {
        VStack {
            Button {
                happeningFetcher.fetchHappenings()
            } label: {
                Text("fetch arrangementer")
            }.padding()
        }
    }
    
    /*func fetchHappenings() {
        //var res: [Happening]
        let query = client.query([Happening].self, query: happeningQuery)
        query.fetch { completion in
            DispatchQueue.main.async {
                switch(completion) {
                case .success(let response):
                     dump(response.result)
                case .failure(let error):
                    dump(error)
                }
            }
        }
        
    }*/
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

struct Happening: Decodable {
    
    static let queryAll = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false).query([Happening].self, query: happeningQuery)
    static let queryListen = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false).query(Happening.self, query: happeningQuery)
    
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
    
    let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)

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
        /*let query = client.query([Happening].self, query: happeningQuery)
        query.fetch { completion in
            DispatchQueue.main.async {
                switch(completion) {
                case .success(let response):
                    print(response.result)
                     dump(response.result)
                case .failure(let error):
                    dump(error)
                }
            }
        }*/
        
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
