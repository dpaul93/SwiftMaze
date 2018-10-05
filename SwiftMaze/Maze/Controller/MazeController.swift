//
//  MazeController.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 02.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

// MARK: - Protocol

protocol MazeController {
    var size: Size { get set }
    
    func generate() -> MazeNode?
}

// MARK: - Implementation

private class BaseMazeController: MazeController {
    private weak var view: SKView?
    private(set) var field: Field?
    private(set) var container: MazeNode?
    var size: Size = .zero
    
    init(view: SKView) {
        self.view = view
        setupGestureRecognizers()
    }
    
    deinit {
        removeGestureRecognizers()
    }
    
    // MARK: – MazeController
    
    func setupGestureRecognizers() {
        removeGestureRecognizers()
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        pinchRecognizer.cancelsTouchesInView = false
        view?.addGestureRecognizer(pinchRecognizer)
    }
    
    func removeGestureRecognizers() {
        view?.gestureRecognizers?.forEach { view?.removeGestureRecognizer($0) }
    }
    
    func generate() -> MazeNode? {
        guard size.height > 0 && size.width > 0 else { return nil }
        
        reset()
        
        let algorithm = MazeAlgorithmFactory.depthFirstMazeAlgorithm()
        let generator = MazeGeneratorFactory.rectangle(size: size)
        let builder = MazeBuilderFactory.default(algorithm: algorithm, generator: generator)
        let field = builder.generate()
        let drawer = MazeDrawerFactory.default(field: field)
        let container = drawer.draw()
        container.isUserInteractionEnabled = true
        
        self.field = field
        self.container = container
        
        return container
    }
    
    // MARK: - Gesture handling
    
    @objc func handlePinch(_ pinchRecognizer: UIPinchGestureRecognizer) {
        guard let container = container else { return }
        let delta = container.xScale * pinchRecognizer.scale
        container.setScale(delta)
        pinchRecognizer.scale = 1
    }
    
    // MARK: - Helpers
    
    func reset() {
        self.container?.removeFromParent()
        self.field = nil
        self.container = nil
    }
}

// MARK: - Factory

class MazeControllerFactory {
    static func `default`(view: SKView) -> MazeController {
        return BaseMazeController(view: view)
    }
}
