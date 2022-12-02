//
//  MainContent.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct MainContent: View {
    //@State private var bedpressPresented:Bool = false
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    let bedpresser = [
        "NBIM": "20. des",
        "Bouvet": "10. nov",
        "DNB": "31. okt",
        "Visma": "4. jun",
    ]
    
    let happenings = [
        "Julelunsj med Hyggkom🎄": "21. jan",
        "Eksamensfest med Tilde🥳": "11. feb",
        "Vinterball🥂": "6. sep",
        "Bedriftstur til Oslo🏙": "4. nov",
        "Eksamen": "19. des"
    ]
    
    var body: some View {
        VStack {
            /*Button(action: {self.bedpressPresented.toggle()}) {InfoContainer(title: "Arrangementer", data: happenings)
            }
            .sheet(isPresented: $bedpressPresented){
                InfoContainer(title: "Arrangementer", data: happenings)
                    .background(.black)
            }*/
            InfoContainer(title: "Arrangementer", data: happenings)
            InfoContainer(title: "Bedpresser", data: bedpresser)
        }
        .padding(.horizontal, 20)
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainContent().background(.black)
    }
}


struct InfoContainer: View {
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    
    let title: String
    let data: [String: String]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(Font.system(size: 25))
                    .foregroundColor(.white)
                    .padding()
                Divider()
                    .overlay(.white)
                    .padding(.bottom)
                ScrollView {
                    ForEach(data.sorted(by: <), id: \.key) { name, date in
                        NavigationLink(destination: EventView(text: name, date: date)) {
                            HStack {
                                Text(name)
                                Spacer()
                                Text(date)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 8)
                        }
                    }
                }
            }
            .padding(.bottom)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(echoGradient, lineWidth: 0.5)
            )
        .padding(.vertical)
        }
    }
}

struct EventView: View {
    let text: String
    let date: String
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(text)
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
            }
            Text(date)
                .font(.title2)
                .foregroundColor(.white)
            Spacer()
        }
        .background(.black)
    }
}
