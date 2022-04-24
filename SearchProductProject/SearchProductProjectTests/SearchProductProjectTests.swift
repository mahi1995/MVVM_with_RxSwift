//
//  SearchProductProjectTests.swift
//  SearchProductProjectTests
//
//  Created by Mahika on 24/04/2022.
//

import RxSwift
import RxTest
import XCTest
@testable import SearchProductProject

class SearchProductProjectTests: XCTestCase {
    var viewModel: SearchProductViewModel!
    var input: SearchProductViewModel.Input!
    var disposeBag = DisposeBag()
    var testScheduler: TestScheduler!
    
    override func setUp() {
        viewModel = makeSUT()
        testScheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func test_inputText_stateChangesToEditMode() {
        let result = testScheduler.createObserver(State.self)
        let output = viewModel.transform(input: input)
        output.state.asObservable()
            .bind(to: result)
            .disposed(by: disposeBag)
        
        testScheduler.start()
        input.searchTerm.accept("test")
        XCTAssertEqual(result.events.last?.value.element, State.editMode)
    }
    
    func test_deleteAllText_stateChangesToEmptyView() {
        let result = testScheduler.createObserver(State.self)
        let output = viewModel.transform(input: input)
        output.state.asObservable()
            .bind(to: result)
            .disposed(by: disposeBag)
        
        testScheduler.start()
        input.searchTerm.accept("")
        XCTAssertEqual(result.events.last?.value.element, State.emptyView)
    }

}

extension SearchProductProjectTests {
    func makeSUT() -> SearchProductViewModel {
        let viewModel = SearchProductViewModel()
        input = SearchProductViewModel.Input()
        return viewModel
    }
}
