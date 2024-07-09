//
//  MultipeerConnectorApp.swift
//  MultipeerChat
//
//  Created by dave on 04/07/24.
//

import SwiftUI

@main
struct MultipeerChatApp: App {
    
    var mpcInterface: MPCInterface = MPCInterface()
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environment(mpcInterface)
                .environment(ViewModel(mpcInterface: mpcInterface))
            
        }
    }
}
