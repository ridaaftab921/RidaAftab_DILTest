//
//  ColorCell.swift
//  GhostDrawingBoard
//
//  Created by Rida Aftab on 10/11/2023.
//

import UIKit

class ColorCell: UICollectionViewCell {
    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? setBorder() : removeBorder()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(color: DrawingColor) {
        self.backgroundColor = color.config.color
    }
    
    func setBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3.0
    }
    
    func removeBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.0
    }
}
