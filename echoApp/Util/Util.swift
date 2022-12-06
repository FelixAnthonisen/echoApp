//
//  Gradient.swift
//  echoApp
//
//  Created by Felix Anthonisen on 06/12/2022.
//

import Foundation
import SwiftUI


class Util{
    class func gradient() -> LinearGradient {
        return LinearGradient(
            colors: [Color("GradientStart"), Color("GradientEnd")],
            startPoint: .top, endPoint: .bottom)
    }
}
