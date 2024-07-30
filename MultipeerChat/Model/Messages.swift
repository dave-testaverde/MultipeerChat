//
//  Messages.swift
//  MultipeerChat
//
//  Created by Dave on 29/07/24.
//

import Foundation

import RxSwift
import RxRelay

@Observable
class Messages {
    static let zeroState = MessageState(idMPC: "", payload: "", isHost: true, isShowable: false)
    
    /// _ Observable component  _
    private var currentState: MessageState {
        willSet{
            print("change state")
        }
    }
    var searchMessage: String = "" {
        didSet {
            self.notifyEvent()
        }
    }
    
    var filteredMessages: [MessageState] = []
    var listMessages: [MessageState]
    
    var messageSelected: MessageState
    var lastState: MessageState
    
    /// _ Rx component  _
    var reducer = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    init() {
        self.currentState = Messages.zeroState
        self.listMessages = []
        
        self.messageSelected = Messages.zeroState
        self.lastState = Messages.zeroState
        
        setupRx()
    }
    
    func getState() -> MessageState {
        return self.currentState
    }
    
    func setState(messageState: MessageState){
        self.currentState = messageState
    }
    
    func reset() {
        self.currentState = Messages.zeroState
        self.lastState = Messages.zeroState
        self.messageSelected = Messages.zeroState
        self.listMessages = []
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
