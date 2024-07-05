//
//  MultipeerConnectorApp.swift
//  MultipeerChat
//
//  Created by dave on 04/07/24.
//

import SwiftUI

@main
struct MultipeerConnectorApp: App {
    var body: some Scene {
        WindowGroup {
            StartView().environment(MPCInterface())
        }
    }
}
