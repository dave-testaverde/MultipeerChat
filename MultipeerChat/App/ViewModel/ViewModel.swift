//
//  ViewModel.swift
//  MultipeerChat
//
//  Created by dave on 08/07/24.
//

import Foundation
import MultipeerConnectivity

@Observable
class ViewModel {
    var currentState: MessageState
    var recvLastState: MessageState
    var listMessages: [MessageState]
    var mpcInterface: MPCInterface
    
    var namePeerConnected: String
    
    let zeroState = MessageState(idMPC: "", payload: "", isHost: true)
    
    init(mpcInterface: MPCInterface) {
        self.currentState = zeroState
        self.recvLastState = zeroState
        self.mpcInterface = mpcInterface
        self.listMessages = []
        self.namePeerConnected = ""
    }
    
    func syncListMessages(){
        self.listMessages.append(self.currentState)
    }
}
