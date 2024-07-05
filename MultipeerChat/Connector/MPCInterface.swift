//
//  MPCInterface.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import Foundation
import MultipeerConnectivity
import SwiftUI

protocol Connectivity {
    func initImpl(username: String) -> Void
    func isPaired() -> Bool
    
    func getUsername() -> String
    
    func sendState(state: SenderState) -> Void
    func getState() -> SenderState
    
    func disconnect() -> Void
}

@Observable class MPCInterface : Connectivity {
    
   var mpcSession: MPCImpl?
    
   func initImpl(username: String) -> Void {
        mpcSession = MPCImpl(username: username)
    }
    
    func Catchable(f: () throws -> ()) -> Bool {
        do{
            try f()
            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    func isPaired() -> Bool {
        return mpcSession!.paired
    }
    
    func getUsername() -> String {
        return mpcSession!.username
    }
    
    func sendState(state: SenderState) -> Void {
        mpcSession!.send(state: state.getPayload())
    }
    
    func getState() -> SenderState {
        return SenderState(payload: mpcSession!.receivedState)
    }
    
    func disconnect() -> Void {
        mpcSession!.session.disconnect()
    }
}
