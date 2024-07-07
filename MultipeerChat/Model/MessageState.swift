//
//  SenderState.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import Foundation
import MultipeerConnectivity

class MessageState {
    private var idMPC: MCPeerID
    private var payload: String
    
    init(idMPC: MCPeerID, payload: String) {
        self.idMPC = idMPC
        self.payload = payload
    }
    
    func getPayload() -> String {
        return payload
    }
    
}
