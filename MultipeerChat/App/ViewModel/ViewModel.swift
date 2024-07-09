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
    var mpcInterface: MPCInterface
    
    let zeroState = MessageState(idMPC: "", payload: "")
    
    init(mpcInterface: MPCInterface) {
        self.currentState = zeroState
        self.recvLastState = zeroState
        self.mpcInterface = mpcInterface
    }
}
