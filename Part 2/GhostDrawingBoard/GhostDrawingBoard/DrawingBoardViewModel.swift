//
//  DrawingBoardViewModel.swift
//  GhostDrawingBoard
//
//  Created by Rida Aftab on 10/11/2023.
//

import Foundation

class DrawingBoardViewModel {
    private let colorsArray: [DrawingColor] = [.red, .green, .blue]

    func getColorsCount() -> Int {
        return colorsArray.count
    }
    
    func getColorForIndex(index: Int) -> DrawingColor{
        return colorsArray[index]
    }
}
