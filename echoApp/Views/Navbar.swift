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
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            Spacer()
            Button(action: {
                self.showProfile.toggle()
            }){
                Image(systemName: "person.crop.circle")
                    .foregroundColor(.white)
                    .imageScale(.large)
            }
            .sheet(isPresented: $showProfile){
                switch session.currentState{
                    case .loggedIn:
                    Profile()
                        .background(.black)
                        .environmentObject(session)

                    default:
                    Login()
                        .background(.black)
                        .environmentObject(session)
                    
                }
            }
        }
        .padding()
        
    }
}

struct Navbar_Previews: PreviewProvider {
    static var previews: some View {
        Navbar()
    }
}
