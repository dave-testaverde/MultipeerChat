//
//  ViewModel.swift
//  MultipeerChat
//
//  Created by dave on 08/07/24.
//

import Foundation
import MultipeerConnectivity

import SwiftUI
import RxSwift

@Observable
class ViewModel {
    var currentState: MessageState
    var recvLastState: MessageState
    var listMessages: [MessageState]
    var mpcInterface: MPCInterface
    
    var namePeerConnected: String
    
    let zeroState = MessageState(idMPC: "", payload: "", isHost: true)
    
    var searchMessage: String  = ""
    var filteredMessages: [MessageState] = []
    
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




