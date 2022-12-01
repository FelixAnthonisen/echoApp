//
//  Navbar.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct Navbar: View {
    var body: some View {
        HStack {
            Image("echoLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            Spacer()
            Button(action: {
                //toggle sheet
            }){
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(Color("BW"))
                    .imageScale(.large)
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
