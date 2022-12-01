//
//  MainContent.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct MainContent: View {
    var body: some View {
        VStack {
            Happenings()
                .padding(.bottom)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white, lineWidth: 2)
                )
                .padding(.vertical)
            Bedpress()
                .padding(.bottom)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white, lineWidth: 2)
                )
                .padding(.vertical)
        }
        .padding(.horizontal, 30)
    }
}

struct MainContent_Previews: PreviewProvider {
    static var previews: some View {
        MainContent().background(.black)
    }
}
