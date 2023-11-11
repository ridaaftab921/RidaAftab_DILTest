//
//  ViewController.swift
//  GhostDrawingBoard
//
//  Created by Rida Aftab on 10/11/2023.
//

import UIKit

protocol DrawingBoardViewDelegate: UIView {
    func didSelectColor(_ color: DrawingColor)
    func didTapEraser()
}

class DrawingBoardViewController: UIViewController {
    
    var viewModel: DrawingBoardViewModel = DrawingBoardViewModel()
    var drawingBoard: DrawingBoardViewDelegate
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 40, height: 40)
        let frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width, height: 40))
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.isUserInteractionEnabled = true
        return cv
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = true
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var toolBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = true
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var eraser: UIButton = {
        var bordered = UIButton.Configuration.bordered()
        bordered.image = UIImage(named: "eraser")
        let button = UIButton(configuration: bordered, primaryAction: nil)
        button.addTarget(self, action:#selector(self.erase), for: .touchUpInside)
        return button
    }()
    
    
    init(drawingBoard: DrawingBoardViewDelegate) {
        self.drawingBoard = drawingBoard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {        
        view.backgroundColor = .white
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant:0),
            drawingBoard.widthAnchor.constraint(equalToConstant: view.frame.width),
            toolBarStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            toolBarStackView.heightAnchor.constraint(equalToConstant: 50.0),
        ])
        
        stackView.addArrangedSubview(drawingBoard)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "color_cell")
        
        eraser.layer.borderColor = UIColor.black.cgColor
        eraser.layer.cornerRadius = 8.0
        
        toolBarStackView.addArrangedSubview(collectionView)
        toolBarStackView.addArrangedSubview(eraser)
        
        stackView.addArrangedSubview(toolBarStackView)
        
        collectionView.reloadData()
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    @objc func erase() {
        collectionView.indexPathsForSelectedItems?
            .forEach { collectionView.deselectItem(at: $0, animated: false) }
        
        eraser.layer.borderWidth = 3.0
        drawingBoard.didTapEraser()
    }
    
}

extension DrawingBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getColorsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "color_cell", for: indexPath) as! ColorCell
        cell.configureCell(color: viewModel.getColorForIndex(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eraser.layer.borderWidth = 0.0
        drawingBoard.didSelectColor(viewModel.getColorForIndex(index: indexPath.row))
    }
}
