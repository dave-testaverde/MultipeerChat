//
//  SenderState.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import Foundation

class SenderState {
    private var payload: String
    
    init(payload: String) {
        self.payload = payload
    }
    
    func getPayload() -> String {
        return payload
    }
    
}
