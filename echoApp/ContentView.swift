//
//  ContentView.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session = SessionManager()
    
    let backgroundGradient = LinearGradient(
        colors: [Color("GradientStart"), Color("GradientEnd")],
        startPoint: .top, endPoint: .bottom)
    var body: some View {
        NavigationStack {
            VStack {
                Navbar()
                    .environmentObject(session)
                VStack {
                    Spacer()
                    MainContent()
                    Spacer()
                    Footer()
                }
            }
            .background(backgroundGradient)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
