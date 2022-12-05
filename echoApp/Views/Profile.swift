//
//  Profile.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var session: SessionManager
    let backgroundGradient = LinearGradient(
        colors: [Color("GradientStart"), Color("GradientEnd")],
        startPoint: .top, endPoint: .bottom)
    var body: some View {
        VStack {
            Text("Min profil")
                .font(.largeTitle)
                .foregroundColor(.white)
            HStack{
                Image(systemName: "person.crop.circle")
                    .imageScale(.large)
                    .foregroundColor(.white)
                Text("Torger Bocianowski")
                    .font(.title3)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            HStack{
                Image(systemName: "envelope")
                    .imageScale(.large)
                    .foregroundColor(.white)
                Text("torgerboc@gmail.com")
                    .font(.title3)
                Spacer()
            }
            .padding()
            
            HStack{
            }
            Spacer()
            Button(action: {
                withAnimation {
                    session.logout()
                }
            }){
                Text("Logg ut")
                    .foregroundColor(.black)
                    .font(.title2)
                    .bold()
            }
            .padding([.horizontal], 20)
            .padding([.vertical], 10)
            .background(.teal)
            .foregroundColor(.white)
            .cornerRadius(20)
        }
        .padding(.top)
        .background(backgroundGradient)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
