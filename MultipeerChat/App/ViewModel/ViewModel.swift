//
//  ViewModel.swift
//  MultipeerChat
//
//  Created by dave on 08/07/24.
//

import Foundation
import MultipeerConnectivity

import SwiftUI

@Observable
class ViewModel {
    var messages: Messages
    
    var mpcInterface: MPCInterface
    var namePeerConnected: String
    
    init(mpcInterface: MPCInterface) {
        self.messages = Messages()
        self.mpcInterface = mpcInterface
        
        self.namePeerConnected = ""
    }
}




