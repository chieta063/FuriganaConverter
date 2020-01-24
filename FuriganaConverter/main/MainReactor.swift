//
//  MainReactor.swift
//  FuriganaConverter
//
//  Created by 阿部紘明 on 2020/01/24.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional
import ReactorKit

struct EmptyValue: Equatable {
    
}

class MainReactor: Reactor {
    
    enum Action {
        case paste(String)
        case reset
    }
    
    struct State {
        fileprivate(set) var convertedText: String
        fileprivate(set) var reset: EmptyValue?
    }
    
    enum Mutation {
        case convert(String)
        case reset
    }
    
    private let convertApi: ConvertAPI
    let initialState: State
    
    init(convertApi: ConvertAPI) {
        self.convertApi = convertApi
        self.initialState = State(convertedText: "", reset: nil)
    }
    
    func mutate(action: MainReactor.Action) -> Observable<MainReactor.Mutation> {
        switch action {
        case let .paste(text):
            return ConvertAPI().convertToHiragana(sentence: text)
                .flatMap { result in Observable.just(Mutation.convert(result)) }
        case .reset:
            return Observable.just(Mutation.reset)
        }
    }
    
    func reduce(state: MainReactor.State, mutation: MainReactor.Mutation) -> MainReactor.State {
        var newState = state
        switch mutation {
        case let .convert(convertedText):
            newState.convertedText = convertedText
            newState.reset = nil
        case .reset:
            newState.reset = EmptyValue()
        }
        return newState
    }
}
