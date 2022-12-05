//
//  Login.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var session: SessionManager
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    let backgroundGradient = LinearGradient(
        colors: [Color("GradientStart"), Color("GradientEnd")],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Text("Velkommen til \nECHO")
                    .font(Font.system(size: 40))
                    .foregroundColor(.white)
                Image("echoLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)
                Spacer()
            }
            .padding()
            Text("Logg inn med Feide på en eller annen måte xD")
                .foregroundColor(.white)
            Spacer()
            Button (action: {
                withAnimation {
                    session.faceIDAuth()
                }
            }) {
                Text("Logg inn")
                    .foregroundColor(.black)
                    .font(.title2)
                    .bold()
            }
            .padding([.horizontal], 20)
            .padding([.vertical], 10)
            .background(.teal)
            .foregroundColor(.white)
            .cornerRadius(20)
        }.background(backgroundGradient)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
