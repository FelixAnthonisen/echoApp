//
//  Login.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text("Welcome")
                .font(Font.system(size: 40))
                .offset(x: -100, y: -100)
            Text("Logg inn med Feide på en eller annen måte xD")
            Spacer()
            Button (action: {
                withAnimation {
                    session.login()
                }
            }) {
                    Text("Logg inn").font(Font.system(size: 22))
                }
                .padding([.horizontal], 20)
                .padding([.vertical], 10)
                .fontWeight(.bold)
                .background(Color.blue)

                .foregroundColor(.white)
                .cornerRadius(20)
        
                Spacer()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
