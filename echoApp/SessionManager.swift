//
//  SessionManager.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum CurrentState {
        case loggedIn
        case loggedOut
    }
    
    @Published private(set) var currentState: CurrentState?

    func login() {
        currentState = .loggedIn
    }
    
    func logout() {
        currentState = .loggedOut
    }

}
