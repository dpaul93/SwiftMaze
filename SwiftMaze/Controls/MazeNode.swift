//
//  MazeNode.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 03.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

class MazeNode: SKSpriteNode {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        let touch = touches.first!
        let cur = touch.location(in: self)
        let prev = touch.previousLocation(in: self)
        let res = CGPoint(x: cur.x - prev.x, y: cur.y - prev.y)
        
        position.x += res.x
        position.y += res.y
    }
}
