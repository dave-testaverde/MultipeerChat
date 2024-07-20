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
        
        Text(viewModel.messageSelected.payload)
    }
}
