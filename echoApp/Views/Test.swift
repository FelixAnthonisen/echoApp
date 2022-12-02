//
//  Test.swift
//  echoApp
//
//  Created by Torger Bocianowski on 02/12/2022.
//

import SwiftUI

struct Test: View {
    let dict = ["NBIM": "12. Des", "DNB": "30. nov", "Bouvet": "31. okt"]
        
    var body: some View {
        NavigationStack {
            ForEach(dict.sorted(by: >), id: \.key) { key, value in
                Section(header: Text(key)) {
                    NavigationLink(destination: Login()) {
                        Text("\(key) er \(value)")
                    }
                }.border(.red)
            }
        }
    }
    
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
