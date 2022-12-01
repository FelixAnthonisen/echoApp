//
//  MainContent.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct MainContent: View {
    let echoGradient = LinearGradient(
        colors: [.yellow, .teal],
        startPoint: .top, endPoint: .bottom)
    var body: some View {
        VStack {
            Happenings()
                .padding(.bottom)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(echoGradient, lineWidth: 2)
                )
                .padding(.vertical)
            Bedpress()
                .padding(.bottom)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(echoGradient, lineWidth: 2)
                )
                .padding(.vertical)
        }
        .padding(.horizontal, 20)
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainContent().background(.black)
    }
}
