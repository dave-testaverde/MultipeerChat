//
//  StartView.swift
//  MultipeerChat
//
//  Created by dave on 05/07/24.
//

import SwiftUI

struct StartView: View {
    
    @Environment(MPCInterface.self) var mpcInterface
    @State var currentView: Int = 0
    @State var username = ""
    
    var body: some View {
        switch currentView {
        case 1:
            PairView(currentView: $currentView)
        default:
            startViewBody
        }
    }
    
    var startViewBody: some View {
        VStack {
            HStack {
                Text("Enter a nickname below. Choose something your friend will recognize!")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)
            }
            HStack {
                TextField("Nickname", text: $username)
                    .padding([.horizontal], 75.0)
                    .padding(.bottom, 24)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Button("Continue →") {
                    mpcInterface.initImpl(username: username)
                    currentView = 1
                }.buttonStyle(BorderlessButtonStyle())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(12)
                    .disabled(username.isEmpty ? true : false)
            }
            HStack {
                Spacer()
            }
        }
    }
}
