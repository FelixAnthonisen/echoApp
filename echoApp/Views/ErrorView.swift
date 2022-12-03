//
//  ErrorView.swift
//  echoApp
//
//  Created by Torger Bocianowski on 03/12/2022.
//

import SwiftUI
import Sanity

struct ErrorView: View {
    let error: Error

        var body: some View {
            if let error = self.error as? SanityClient.Query<[Happening]>.ErrorResponse, let queryError = error.queryError {
                Text("query error: \(queryError.queryError)").foregroundColor(.red)

                HStack {
                    Text("query: \(queryError.query)")
                    Spacer()
                }
            } else {
                Text("error: \(error.localizedDescription)").foregroundColor(.red)
            }
        }
}


