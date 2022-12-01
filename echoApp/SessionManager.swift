//
//  SessionManager.swift
//  echoApp
//
//  Created by Torger Bocianowski on 01/12/2022.
//

import Foundation
import LocalAuthentication

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
    
    
    func faceIDAuth() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is for security reasons") { success, authenicationError in
                if success {
                    self.login()
                } else {
                    print("did not work")
                }
            }
        } else {
            print("fuck")
        }
    }

}
