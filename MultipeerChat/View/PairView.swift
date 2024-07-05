//
//  PairView.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import SwiftUI
import os

struct PairView: View {
    
    @Environment(MPCInterface.self) var mpcInterface
    @Binding var currentView: Int
    
    var logger = Logger()
        
    var body: some View {
        @Bindable var mpcInterface = mpcInterface
        @Bindable var mpcSession = mpcInterface.mpcSession!
        if(!mpcInterface.isPaired()){
            ListFriend()
            .alert(
                "Received an invite from \(mpcInterface.mpcSession!.recvdInviteFrom?.displayName ?? "ERR")!",
                isPresented: $mpcSession.recvdInvite
            ) {
                Button("Accept") {
                    if (mpcInterface.mpcSession!.invitationHandler != nil) {
                        mpcInterface.mpcSession!.invitationHandler!(true, mpcInterface.mpcSession!.session)
                    }
                }
                Button("Reject") {
                    if (mpcInterface.mpcSession!.invitationHandler != nil) {
                        mpcInterface.mpcSession!.invitationHandler!(false, nil)
                    }
                }
            }
        } else {
            SenderView(currentView: $currentView)
        }
    }
}
