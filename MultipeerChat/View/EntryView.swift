//
//  EntryView.swift
//  MultipeerChat
//
//  Created by dave on 09/07/24.
//

import SwiftUI

struct EntryView: View {
    
    @Environment(ViewModel.self) var viewModel
    @Environment(Router.self) var router
    
    var body: some View {
        VStack {
            HStack {
                Button("Let's have a chat →") {
                    router.navigateTo(route: .startView)
                }.buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(12)
            }
            HStack {
                Spacer()
            }
        }
    }
}
