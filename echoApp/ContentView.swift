//
//  ContentView.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session = SessionManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                Navbar()
                    .environmentObject(session)
                ScrollView {
                    VStack {
                        Spacer()
                        MainContent()
                        Spacer()
                        Footer()
                    }
                }
            }
            .background(Util.gradient())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
