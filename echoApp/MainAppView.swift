//
//  MainAppView.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import SwiftUI

struct MainAppView: View {
    @StateObject private var session = SessionManager()
    var body: some View {
            ContentView()
            .environmentObject(session)
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView().preferredColorScheme(.dark)
    }
}
