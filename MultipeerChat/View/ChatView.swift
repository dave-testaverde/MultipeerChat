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
    @Environment(Router.self) var router
        
    @State var messageToSend: String = ""
    @State var isShowable: Bool = false
    
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
                            Button(message.payload) {
                                if(message.isShowable){
                                    viewModel.messageSelected = message
                                    router.navigateTo(route: .messageView)
                                }
                            }
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
                VStack{
                    VStack{
                        Toggle(isOn: $isShowable, label: {
                            Text("Show Text")
                                .padding(.all, 10)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .background( .orange )
                                .cornerRadius(20)
                        })
                    }.frame(width: 170)
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
                                    isShowable: isShowable
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
}

#Preview {
    ChatView()
}
