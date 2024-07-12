//
//  SenderState.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import Foundation
import MultipeerConnectivity

struct MessageState: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    
    var isHost: Bool
    var idMPC: String
    var payload: String
    
    init(idMPC: String, payload: String, isHost: Bool) {
        self.idMPC = idMPC
        self.payload = payload
        self.isHost = isHost
    }
    
    static func encodeJSON(state: MessageState) -> String {
        let jsonData = try! JSONEncoder().encode(state)
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        return jsonString!
    }
    
    static func decodeJSON(json: String) -> MessageState {
        let decoder = JSONDecoder()
        let state = try! decoder.decode(MessageState.self, from: json.data(using: .utf8)!)
        
        return state
    }
    
}
