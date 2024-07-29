//
//  MessageView.swift
//  MultipeerChat
//
//  Created by Dave on 20/07/24.
//

import SwiftUI

struct MessageView: View {
    
    @Environment(ViewModel.self) var viewModel
    @Environment(MPCInterface.self) var mpcInterface
    
    var body: some View {
        @Bindable var viewModel = viewModel
        @Bindable var mpcInterface = viewModel.mpcInterface
        
        var message = viewModel.messages.messageSelected
        
        Text(message.payload)
            .frame(width: 170)
            .padding(.all, 8)
            .font(.system(size: 16))
            .foregroundColor(.white)
            .background( (message.isHost) ? .green : .blue)
            .cornerRadius(20)
    }
}
