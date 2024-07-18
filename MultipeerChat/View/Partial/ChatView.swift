//
//  ChatView.swift
//  MultipeerChat
//
//  Created by dave on 11/07/24.
//

import Foundation
import SwiftUI

struct ChatView: View {
    
    @Environment(ViewModel.self) var viewModel
    @Environment(MPCInterface.self) var mpcInterface
        
    @State var messageToSend: String = ""
    
    var body: some View {
        @Bindable var viewModel = viewModel
        @Bindable var mpcInterface = viewModel.mpcInterface
        @Bindable var mpcSession = mpcInterface.mpcSession!
        
        HStack {
            ZStack{
                HStack{
                    HStack{
                        TextField("Search", text: $viewModel.searchMessage)
                            .padding(.bottom, 15)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .cornerRadius(12)
                            .onChange(of: viewModel.searchMessage) { oldState, newState in
                                viewModel.notifyEvent()
                            }
                    }
                }
                .frame(width: 350)
            }
        }
        HStack {
            Spacer()
        }
        HStack {
            NavigationSplitView {
                GeometryReader { geometry in
                    List((viewModel.searchMessage.isEmpty) ? viewModel.listMessages : viewModel.filteredMessages) { message in
                        LazyVStack(alignment: (message.isHost) ? .trailing : .leading){
                            Button(message.payload) {}
                                .frame(width: 170)
                                .padding(.all, 8)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .background( (message.isHost) ? .green : .blue)
                                .cornerRadius(20)
                            Text((message.isHost) ? "You" : "Him/Her")
                        }.listRowSeparator(.hidden)
                    }
                    .navigationTitle(viewModel.namePeerConnected)
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
                }
            } detail: {
                Text("Select a Chat")
            }
        }
        HStack {
            ZStack{
                HStack{
                    HStack{
                        TextField("Message", text: $messageToSend)
                            .padding(.bottom, 15)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .cornerRadius(12)
                    }
                    HStack{
                        Button("Send →") {
                            viewModel.currentState = MessageState(
                                idMPC: viewModel.mpcInterface.mpcSession!.username,
                                payload: messageToSend,
                                isHost: true,
                                isShowable: false
                            )
                            
                            mpcInterface.sendState()
                            
                            viewModel.syncListMessages()
                            messageToSend = ""
                        }.buttonStyle(BorderlessButtonStyle())
                            .padding(.horizontal, 20)
                            .padding(.vertical, 7)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                            .disabled(messageToSend.isEmpty ? true : false)
                    }
                    .padding(.bottom, 15)
                }
                .frame(width: 350)
            }
        }
    }
}

#Preview {
    ChatView()
}
