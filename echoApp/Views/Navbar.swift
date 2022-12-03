//
//  Navbar.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct Navbar: View {
    @EnvironmentObject var session: SessionManager
    @State private var isLoggedIn = false
    @State private var showProfile = false
    var body: some View {
        HStack {
            Image("echoLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            Spacer()
            Text("echo")
                .fontWeight(.bold)
                .font(Font.system(size: 35))
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                self.showProfile.toggle()
            }){
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .frame(width: 50)
            }
            .sheet(isPresented: $showProfile){
                
                Section {
                    switch session.currentState{
                        case .loggedIn:
                        Profile()
                        default:
                        Login()
                    }
                }
                .background(.black)
                .environmentObject(session)
                .presentationDetents([.fraction(0.5)])
            }
            
        }
        .padding()
        
    }
}

struct Navbar_Previews: PreviewProvider {
    static var previews: some View {
        Navbar().background(.black)
    }
}
