//
//  GameView.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import SwiftUI

struct SenderView: View {
    
    @Environment(MPCInterface.self) var mpcInterface
    @Binding var currentView: Int
    @State var message: String = ""
    
    var body: some View {
        @Bindable var mpcInterface = mpcInterface
        @Bindable var mpcSession = mpcInterface.mpcSession!
        if(mpcSession.session.connectedPeers.count == 0){
            StartView()
        } else {
            ZStack {
                VStack(alignment: .center) {
                    HStack {
                        TextField("Command", text: $message)
                            .padding([.horizontal], 75.0)
                            .padding(.bottom, 24)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Button("Send →") {
                            mpcInterface.sendState(state: SenderState(payload: message))
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
                        Text(mpcInterface.getState().getPayload())
                            .padding([.horizontal], 75.0)
                            .padding(.bottom, 24)
                            .foregroundColor(Color.blue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        Button("Disconnect") {
                            mpcInterface.disconnect()
                            currentView = 0
                            //onDisconnect = true
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
        SenderView(currentView: .constant(0))
    }
}
