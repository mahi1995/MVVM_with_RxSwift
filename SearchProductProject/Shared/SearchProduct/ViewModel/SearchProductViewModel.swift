//
//  SearchProductViewModel.swift
//  SearchProductProject (iOS)
//
//  Created by Mahika on 24/04/2022.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

struct SearchProductViewModel: ViewModelProtocol {
    
    struct Input {}
    
    struct Output {}
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
