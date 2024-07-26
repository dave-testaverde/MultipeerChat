//
//  ViewModel.swift
//  MultipeerChat
//
//  Created by dave on 08/07/24.
//

import Foundation
import MultipeerConnectivity

import SwiftUI
import RxSwift
import RxRelay

@Observable
class ViewModel {
    
    var currentState: MessageState
    var messageSelected: MessageState
    var recvLastState: MessageState
    var listMessages: [MessageState]
    var mpcInterface: MPCInterface
    
    var namePeerConnected: String
    
    var searchMessage: String = "" {
        willSet{
            print("new " + newValue)
        }
        didSet {
            print("old " + oldValue)
            self.notifyEvent()
        }
    }
    var filteredMessages: [MessageState] = []
    
    let zeroState = MessageState(idMPC: "", payload: "", isHost: true, isShowable: false)
    
    /// _ Rx component & tools _
    
    var reducer = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    init(mpcInterface: MPCInterface) {
        self.currentState = zeroState
        self.messageSelected = zeroState
        self.recvLastState = zeroState
        self.mpcInterface = mpcInterface
        self.listMessages = []
        self.namePeerConnected = ""
        
        setupRx()
    }
    
    func syncListMessages(){
        self.listMessages.append(self.currentState)
    }
    
    func notifyEvent() {
        reducer.onNext(self.searchMessage)
    }
    
    func setupRx() {
        reducer.map({ [self] query in
            filteredMessages = listMessages.filter {
                $0.payload.lowercased().contains(query.lowercased())
            }
        })
        .debug()
        .subscribe(onNext: { value in })
        .disposed(by: disposeBag)
    }
}




