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
            /*ZStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.white)
                Image(systemName: "circle.fill")
                    .imageScale(.large)
                    .offset(x: 25, y: 40)
                    .foregroundColor(.white)
                Image(systemName: "camera.circle")
                    .imageScale(.large)
                    .offset(x: 25, y: 40)
                    .foregroundColor(.black)
            }*/
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
                    .foregroundColor(.white)
                    .font(Font.system(size: 22))
            }
            .padding([.horizontal], 20)
            .padding([.vertical], 10)
            .fontWeight(.bold)
            .background(Color.blue)

            .foregroundColor(.white)
            .cornerRadius(20)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().background(.black)
    }
}
