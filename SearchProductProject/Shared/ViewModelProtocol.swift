//
//  ViewModelProtocol.swift
//  SearchProductProject (iOS)
//
//  Created by Mahika on 27/04/2022.
//

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
