//
//  MainContent.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct MainContent: View {
    //@State private var bedpressPresented:Bool = false
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack {
            BedpressContainer(title: "Bedpresser")
            EventContainer(title: "Arrangementer")
        }
        .padding(.horizontal, 20)
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainContent()
    }
}

    
