//
//  DrawingColor.swift
//  GhostDrawingBoard
//
//  Created by Rida Aftab on 10/11/2023.
//

import UIKit

enum DrawingColor {
    case red
    case blue
    case green
    case erase
    // Add more colors as needed
}

struct ColorConfig {
    let color: UIColor
    let delay: TimeInterval
    let strokeWidth: CGFloat
}

extension DrawingColor {
    var config: ColorConfig {
        switch self {
        case .red:
            return ColorConfig(color: .red, delay: 1.0, strokeWidth: 5.0)
        case .blue:
            return ColorConfig(color: .blue, delay: 3.0, strokeWidth: 5.0)
        case .green:
            return ColorConfig(color: .green, delay: 5.0, strokeWidth: 5.0)
        case .erase:
            return ColorConfig(color: .white, delay: 2.0, strokeWidth: 10.0)

        // Add more colors here with their configurations
        }
    }
}
