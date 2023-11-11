//
//  GhostDrawingBoardTests.swift
//  GhostDrawingBoardTests
//
//  Created by Rida Aftab on 10/11/2023.
//

import XCTest
@testable import GhostDrawingBoard

final class GhostDrawingBoardTests: XCTestCase {
    
    var viewController: DrawingBoardViewController!
    var drawingBoard: MockDrawingBoardViewDelegate!
    
    override func setUp() {
        super.setUp()
        drawingBoard = MockDrawingBoardViewDelegate()
        viewController = DrawingBoardViewController(drawingBoard: drawingBoard)
        
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertNotNil(viewController, "ViewController should not be nil.")
        XCTAssertNotNil(viewController.collectionView, "CollectionView should not be nil.")
        XCTAssertNotNil(viewController.stackView, "StackView should not be nil.")
        XCTAssertNotNil(viewController.toolBarStackView, "ToolBarStackView should not be nil.")
        XCTAssertNotNil(viewController.eraser, "Eraser button should not be nil.")
        XCTAssertNotNil(viewController.drawingBoard, "CanvasView should not be nil.")
        XCTAssertNotNil(viewController.collectionView.dataSource, "data source for the collectionView should not be nil.")
        XCTAssertNotNil(viewController.collectionView.delegate, "delegate for the collectionView should not be nil.")
    }
    
    func testCollectionView() {
        XCTAssertEqual(viewController.getNumberOfColors(), 3)
        
        XCTAssertEqual(viewController.getColorCell(index: 0)?.backgroundColor, .red)
        XCTAssertEqual(viewController.getColorCell(index: 1)?.backgroundColor, .green)
        
        XCTAssertTrue(viewController.getColorCell(index: 0)?.isSelected == true)
        XCTAssertTrue(viewController.getColorCell(index: 1)?.isSelected == false)
    }
    
    func testEraseButtonTapped() {
        viewController.erase()
        // Add assertions to check the delegate's behavior
        XCTAssertTrue(drawingBoard.didTapEraserCalled)
    }
    
    func testColorSelectTapped() {
        viewController.selectCollectionViewCell(at: 1)
        // Add assertions to check the delegate's behavior
        XCTAssertTrue(drawingBoard.didSelectColorCalled)
    }
}

private extension DrawingBoardViewController {
    
    func getNumberOfColors() -> Int {
        return self.collectionView.numberOfItems(inSection: 0)
    }
    
    func getColorCell(index: Int) -> ColorCell? {
        let ds = collectionView.dataSource
        return ds?.collectionView(collectionView, cellForItemAt: IndexPath(row: index, section: 0)) as? ColorCell
    }
    
    func selectCollectionViewCell(at index: Int) {
        collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: IndexPath(row: index, section: 0))
    }
}

class MockDrawingBoardViewDelegate: UIView, DrawingBoardViewDelegate {
    var didSelectColorCalled = false
    var didTapEraserCalled = false
    
    func didSelectColor(_ color: GhostDrawingBoard.DrawingColor) {
        didSelectColorCalled = true
    }
    
    func didTapEraser() {
        didTapEraserCalled = true
    }    
}
