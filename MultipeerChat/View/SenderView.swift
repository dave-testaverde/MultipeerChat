//
//  SenderView.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import SwiftUI

struct SenderView: View {
    
    @Environment(ViewModel.self) var viewModel
    @Environment(Router.self) var router
    
    @State var message: String = ""
    
    var body: some View {
        @Bindable var mpcInterface = viewModel.mpcInterface
        @Bindable var mpcSession = viewModel.mpcInterface.mpcSession!
        if(mpcSession.session.connectedPeers.count == 0){
            StartView()
                .environment(router)
                .environment(viewModel)
        } else {
            ZStack {
                VStack(alignment: .center) {
                    HStack {
                        Button("Chat") {
                            print(mpcInterface.mpcSession!.availablePeers)
                            router.navigateTo(route: .chatView)
                        }.buttonStyle(BorderlessButtonStyle())
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(12)
                            .disabled(viewModel.listMessages.isEmpty ? true : false)
                    }
                    HStack{
                        Divider().frame(width: 200, height: 1).background(Color.blue)
                    }
                    HStack {
                        Spacer()
                    }
                    HStack {
                        TextField("Command", text: $message)
                            .padding([.horizontal], 75.0)
                            .padding(.bottom, 24)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Button("Send →") {
                            viewModel.currentState = MessageState(
                                idMPC: viewModel.mpcInterface.mpcSession!.username,
                                payload: message,
                                isHost: true,
                                isShowable: false
                            )
                            
                            mpcInterface.sendState()
                            
                            viewModel.syncListMessages()
                            message = ""
                        }.buttonStyle(BorderlessButtonStyle())
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                            .disabled(message.isEmpty ? true : false)
                    }
                    HStack {
                        Spacer()
                    }
                    HStack{
                        Divider().frame(width: 200, height: 1).background(Color.blue)
                    }
                    HStack {
                        Spacer()
                    }
                    HStack {
                        Text("Message from user connected")
                            .padding([.horizontal], 75.0)
                            .padding(.bottom, 24)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Spacer()
                    }
                    HStack {
                        Text(viewModel.recvLastState.payload)
                            .padding([.horizontal], 75.0)
                            .padding(.bottom, 24)
                            .foregroundColor(Color.blue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Button("Disconnect") {
                            mpcInterface.disconnect()
                            router.navigationPath.removeLast()
                        }.buttonStyle(BorderlessButtonStyle())
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                }
            }
        }
    }
}

struct SenderView_Previews: PreviewProvider {
    static var previews: some View {
        SenderView()
    }
}
