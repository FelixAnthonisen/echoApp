//
//  Gradient.swift
//  echoApp
//
//  Created by Felix Anthonisen on 06/12/2022.
//

import Foundation
import SwiftUI
import Sanity
import SDWebImageSwiftUI

class Util{
    class func gradient() -> LinearGradient {
        return LinearGradient(
            colors: [Color("GradientStart"), Color("GradientEnd")],
            startPoint: .top, endPoint: .bottom)
    }
    class func echoGradient() -> LinearGradient {
        return LinearGradient(
            colors: [.yellow, .teal],
            startPoint: .top, endPoint: .bottom)
    }
}

struct CircleImage: View {
    let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    let logo: SanityType.Image
    var body: some View {
        WebImage(url: client.imageURL(self.logo)
            .URL()
        )
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40, alignment: .center)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.white, lineWidth: 1)
        }
    }
}

struct SquareImage: View {
    let client = SanityClient(projectId: "pgq2pd26", dataset: "production", useCdn: false)
    let logo: SanityType.Image
    var body: some View {
        WebImage(url: client.imageURL(self.logo)
            .URL()
        )
        .resizable()
        .scaledToFit()
        .frame(width: 120, alignment: .center)
    }
}

struct LinkButton: View {
    let slug: String
    let label: String
    var body: some View {
        Link(destination: URL(string: "https://echo.uib.no/event/\(slug.replacingOccurrences(of: " ", with: "%20"))")!){
            Text(label)
                .bold()
        }
        .frame(width: 150)
        .padding([.horizontal], 20)
        .padding([.vertical], 10)
        .background(.teal)
        .foregroundColor(.black)
        .cornerRadius(20)
    }
}

