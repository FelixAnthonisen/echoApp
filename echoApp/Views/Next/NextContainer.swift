//
//  NextThing.swift
//  echoApp
//
//  Created by Torger Bocianowski on 07/12/2022.
//

import SwiftUI
import Sanity

var query = """
*[_type == "happening" && registrationDate != NULL && slug.current != NULL]
"""


struct NextContainer: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NextContainer_Previews: PreviewProvider {
    static var previews: some View {
        NextContainer()
    }
}
