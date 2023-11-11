//
//  CanvasView.swift
//  GhostDrawingBoard
//
//  Created by Rida Aftab on 10/11/2023.
//

import UIKit

struct PathWithColor {
    let path: UIBezierPath
    let color: DrawingColor
}

class CanvasView: UIView {
    var drawingColor: DrawingColor = .red
    var drawingPath: UIBezierPath?
    var paths: [PathWithColor] = []
    var ctr = 0
    var pts = Array<CGPoint?>(repeating: nil, count: 5)
    
    var canvasImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Draw the canvas image if available
        canvasImage?.draw(in: rect)
        
        // Render the current drawing path
        if let currentPath = paths.last?.path, let currentColor = paths.last?.color {
            currentColor.config.color.setStroke()
            currentPath.lineWidth = currentColor.config.strokeWidth
            currentPath.stroke()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let startPoint = touch.location(in: self)
        drawingPath = UIBezierPath()
        drawingPath?.move(to: startPoint)
        
        ctr = 0
        pts[0] = startPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let path = drawingPath else { return }
        let currentPoint = touch.location(in: self)
        ctr += 1
        pts[ctr] = currentPoint
        
        if ctr == 4 {
            // create cubic Bezier curves when collecting 5 touch points
            pts[3] = CGPoint(x: ((pts[2]?.x ?? 0.0) + (pts[4]?.x ?? 0.0))/2.0, y: ((pts[2]?.y ?? 0.0) + (pts[4]?.y ?? 0.0))/2.0)
            
            if let pt0 = pts[0], let pt3 = pts[3], let pt1 = pts[1], let pt2 = pts[2]  {
                path.move(to: pt0)
                path.addCurve(to: pt3, controlPoint1: pt1, controlPoint2: pt2)
            }
            pts[0] = pts[3]
            pts[1] = pts[4]
            ctr = 1
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let path = drawingPath else { return }
        let color = self.drawingColor

        DispatchQueue.main.asyncAfter(deadline: .now() + color.config.delay) {
            let pathWithColor = PathWithColor(path: path, color: color)
            self.paths.append(pathWithColor)
            self.setNeedsDisplay() // Redraw the canvas with the new stroke
            self.updateCanvasImage() // Update the canvas image with the latest stroke
        }
    }
    
    private func updateCanvasImage() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        draw(self.bounds)
        // Store the image as the canvas
        canvasImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}

extension CanvasView: DrawingBoardViewDelegate {
    
    func didSelectColor(_ color: DrawingColor) {
        self.drawingColor = color
    }
    func didTapEraser() {
        self.drawingColor = .erase
    }
}
