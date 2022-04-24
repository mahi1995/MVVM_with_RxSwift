//
//  SearchProductViewModel.swift
//  SearchProductProject (iOS)
//
//  Created by Mahika on 24/04/2022.
//

import RxCocoa
import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

struct Product {}

internal enum State: Equatable {
    case emptyView
    case editMode
    case error(String)
    case success([Product])
    
    static func == (lhs: State, rhs: State) -> Bool {
        switch (lhs, rhs) {
        case (.emptyView, .emptyView),
            (.editMode, .editMode):
            return true
        default:
            return false
        }
    }
}

struct SearchProductViewModel: ViewModelProtocol {
    struct Input {
        let searchTerm = BehaviorRelay<String>(value: "")
    }
    
    struct Output {
        let state: Driver<State>
    }
    
    func transform(input: Input) -> Output {
        return Output(state: onChangedText(with: input))
    }
    
    func onChangedText(with input: Input) -> Driver<State> {
        input.searchTerm.map { term -> State in
            guard !term.isEmpty else { return .emptyView }
            return .editMode
        }.asDriver(onErrorJustReturn: .emptyView)
    }
}
