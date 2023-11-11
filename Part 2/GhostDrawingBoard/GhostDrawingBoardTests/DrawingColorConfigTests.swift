//
//  DrawingColorConfigTests.swift
//  GhostDrawingBoardTests
//
//  Created by Rida Aftab on 11/11/2023.
//

import XCTest
@testable import GhostDrawingBoard

final class DrawingColorConfigTests: XCTestCase {
    func testRedColorConfig() {
        let config = DrawingColor.red.config
        XCTAssertEqual(config.color, .red)
        XCTAssertEqual(config.delay, 1.0)
        XCTAssertEqual(config.strokeWidth, 5.0)
    }
    
    func testGreenColorConfig() {
        let config = DrawingColor.green.config
        XCTAssertEqual(config.color, .green)
        XCTAssertEqual(config.delay, 5.0)
        XCTAssertEqual(config.strokeWidth, 5.0)
    }
    
    func testBlueColorConfig() {
        let config = DrawingColor.blue.config
        XCTAssertEqual(config.color, .blue)
        XCTAssertEqual(config.delay, 3.0)
        XCTAssertEqual(config.strokeWidth, 5.0)
    }
    
    func testEraserConfig() {
        let config = DrawingColor.erase.config
        XCTAssertEqual(config.color, .white)
        XCTAssertEqual(config.delay, 2.0)
        XCTAssertEqual(config.strokeWidth, 10.0)
    }

}
