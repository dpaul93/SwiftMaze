//
//  GameScene.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var mazeController: MazeController!
    var menu: Menu!
    
    override func didMove(to view: SKView) {
        mazeController = MazeControllerFactory.default(view: view)
        
        menu = MenuFactory.default()
        menu.delegate = self
        addChild(menu.background)
    }    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: MenuDelegate {
    func handleGenerate(with dimension: Int) {
        mazeController.size = Size(width: dimension, height: dimension)
        mazeController.generate().flatMap { addChild($0) }
    }
}
