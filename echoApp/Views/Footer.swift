//
//  Footer.swift
//  echoApp
//
//  Created by Felix Anthonisen on 01/12/2022.
//

import SwiftUI

struct Footer: View {
    var body: some View {
        VStack{
            Divider()
                .overlay(.white)
            HStack{
                Spacer()
                Text("Placeholder")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "face.smiling")
                    .imageScale(.large)
                    .foregroundColor(.white)
                Spacer()
                Text("Powered by \nSANITY")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.vertical)
            Text("Developed by Torger and Felix")
                .foregroundColor(.white)
                .font(.footnote)
        }
        .padding(.bottom)
    }
        
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer().background(.black)
    }
}
