//
//  ListMessages.swift
//  MultipeerChat
//
//  Created by dave on 11/07/24.
//

import Foundation
import SwiftUI

struct ListMessages: View {
    
    @Environment(ViewModel.self) var viewModel
    @Environment(MPCInterface.self) var mpcInterface
    
    @State var messageToSend: String = ""
    
    var body: some View {
        @Bindable var viewModel = viewModel
        @Bindable var mpcInterface = viewModel.mpcInterface
        @Bindable var mpcSession = mpcInterface.mpcSession!
        
        HStack {
            Spacer()
        }
        HStack {
            Spacer()
        }
        HStack {
            NavigationSplitView {
                List(viewModel.listMessages) { message in
                    HStack{
                        GeometryReader { geometry in
                            HStack {
                                HStack {
                                    Button(message.payload) {}
                                        .frame(width: 170, height: 25)
                                        .padding(.all, 5)
                                        .foregroundColor(.white)
                                        .background( (message.isHost) ? .green : .blue)
                                        .cornerRadius(20)
                                }
                                .frame(width: 170, alignment: (message.isHost) ? .trailing : .leading)
                            }
                            .listRowBackground(Color.white)
                            .frame(width: geometry.size.width, alignment: (message.isHost) ? .trailing : .leading)
                        }
                    }
                    .listRowSeparator(.hidden)
                    HStack{
                        HStack{
                            Text((message.isHost) ? "" : "Him/Her")
                            Spacer()
                        }
                        HStack{
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text((message.isHost) ? "You" : "")
                        }
                    }
                    .listRowBackground(Color.white).listRowSeparator(.hidden)
                }
                .navigationTitle(viewModel.namePeerConnected)
                .scrollContentBackground(.hidden)
                .background(Color.white)
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
                                isHost: true
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
    ListMessages()
}
