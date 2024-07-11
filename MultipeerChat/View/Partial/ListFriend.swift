//
//  ListFriend.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import SwiftUI

struct ListFriend: View {
    
    @Environment(MPCInterface.self) var mpcInterface
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        @Bindable var mpcInterface = mpcInterface
        @Bindable var mpcSession = mpcInterface.mpcSession!
        HStack {
            Spacer()
        }
        HStack {
            HStack {
                HStack {
                    HStack {
                        Text(mpcInterface.getUsername())
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                    }
                    .padding(.all, 7)
                }
                .frame(width: 150, height: 30)
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.green, lineWidth: 1.5)
                    
                ).onTapGesture {
                   
                }
            }
        }
        HStack {
            Spacer()
        }
        HStack {
            NavigationSplitView {
                List(mpcInterface.mpcSession!.availablePeers, id: \.self) { peer in
                    Button(peer.displayName) {
                        mpcInterface.mpcSession!.serviceBrowser.invitePeer(peer, to: mpcInterface.mpcSession!.session, withContext: nil, timeout: 30)
                        viewModel.namePeerConnected = peer.displayName
                    }
                } .navigationTitle("Friends")
            } detail: {
                Text("Select a Friend")
            }
        }
    }
}

#Preview {
    ListFriend()
}
