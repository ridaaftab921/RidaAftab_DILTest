//
//  DrawingBoardViewModelTests.swift
//  GhostDrawingBoardTests
//
//  Created by Rida Aftab on 10/11/2023.
//


import XCTest
@testable import GhostDrawingBoard

final class DrawingBoardViewModelTests: XCTestCase {
    
    var viewModel: DrawingBoardViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = DrawingBoardViewModel()
    
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testColors() {
        XCTAssertEqual(viewModel.getColorsCount(), 3)
        XCTAssertEqual(viewModel.getColorForIndex(index: 0), .red)
        XCTAssertEqual(viewModel.getColorForIndex(index: 1), .green)
        XCTAssertEqual(viewModel.getColorForIndex(index: 2), .blue)
    }
}
