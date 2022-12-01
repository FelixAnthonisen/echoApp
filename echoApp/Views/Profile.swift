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
        HStack{
            Spacer()
            VStack {
                ZStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
                }
                
                Text("Torger Bocianowski")
                    .font(Font.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
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
            .padding(.top)
            Spacer()
        }
       
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().background(.black)
    }
}
