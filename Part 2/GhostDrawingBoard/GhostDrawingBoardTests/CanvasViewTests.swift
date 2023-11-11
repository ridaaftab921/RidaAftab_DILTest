//
//  CanvasViewTests.swift
//  GhostDrawingBoardTests
//
//  Created by Rida Aftab on 11/11/2023.
//

import XCTest
@testable import GhostDrawingBoard

final class CanvasViewTests: XCTestCase {
    var canvasView: CanvasView!
    override func setUp() {
        super.setUp()
        canvasView = CanvasView()
        
    }
    
    override func tearDown() {
        canvasView = nil
        super.tearDown()
    }
    
    func testCanvasView() {
        XCTAssertEqual(canvasView.drawingColor, .red)
        
        canvasView.didTapEraser()
        XCTAssertEqual(canvasView.drawingColor, .erase)
        
        canvasView.didSelectColor(.blue)
        XCTAssertEqual(canvasView.drawingColor, .blue)
        
    }
}
