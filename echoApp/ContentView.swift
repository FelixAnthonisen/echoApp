//
//  ContentView.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionManager
    let backgroundGradient = LinearGradient(
        colors: [Color("GradientStart"), Color("GradientEnd")],
        startPoint: .top, endPoint: .bottom)
    var body: some View {
        VStack{
            Navbar()
                .environmentObject(session)
            ScrollView{
                VStack {
                    Spacer()
                    MainContent()
                    Group{
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                    }
                    .padding()
                    Group{
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                        Text("TEST")
                    }
                    .padding()
                    Spacer()
                    Footer()
                }
               
            }
            .background(Color.black.opacity(0))
        }
        .background(backgroundGradient)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.light)
    }
}
