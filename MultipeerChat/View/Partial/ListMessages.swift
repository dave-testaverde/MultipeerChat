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
    
    var body: some View {
        @Bindable var viewModel = viewModel
        @Bindable var mpcInterface = viewModel.mpcInterface
        @Bindable var mpcSession = mpcInterface.mpcSession!
        HStack {
            Spacer()
        }
        HStack {
            HStack {
                HStack {
                    HStack {
                        Text(viewModel.namePeerConnected)
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
                List(viewModel.listMessages.reversed()) { message in //peer in
                    
                    /*VStack(alignment: .center){
                        Button(message.payload) {}
                        .frame(width: 150, height: 30)
                        .foregroundColor(.white)
                        .background( (message.isHost) ? .green : .blue)
                        .cornerRadius(20)
                    }.listRowBackground(Color.white)
                        .frame(width: 150, height: 30)*/
                        
                    HStack{
                        HStack{
                            Text("")
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Button(message.payload) {}
                            .frame(width: 200, height: 30)
                            .foregroundColor(.white)
                            .background( (message.isHost) ? .green : .blue)
                            .cornerRadius(20)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("")
                        }
                    }.listRowBackground(Color.white)
                    
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
                    }.listRowBackground(Color.white)
                }
                .navigationTitle("Chat")
                .scrollContentBackground(.hidden)
                .background(Color.white)
            } detail: {
                Text("Select a Friend")
            }
        }
    }
}

#Preview {
    ListMessages()
}
