//
//  Profile.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var session: SessionManager
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                Image(systemName: "circle.fill")
                    .imageScale(.large)
                    .offset(x: 25, y: 40)
                    .foregroundColor(Color("BW"))
                Image(systemName: "camera.circle")
                    .imageScale(.large)
                    .offset(x: 25, y: 40)
                    .foregroundColor(Color("WB"))
            }
            
            Text("Torger Bocianowski")
                .font(Font.system(size: 30, weight: .bold))
                .padding()
            Spacer()
            Button(action: {
                withAnimation {
                    session.logout()
                }
            }) {
                Text("Logg ut").font(Font.system(size: 22))
            }
        }.padding()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
