//
//  Cell.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import CoreGraphics

class Cell {
    private var walls: Wall
    let position: Position
    
    init(position: Position, walls: Wall? = nil) {
        self.position = position
        self.walls = walls ?? Wall()
    }
    
    func setAllWallsUp() {
        walls = Wall()
    }
    
    func containsWall(_ wall: Wall) -> Bool {
        return walls.contains(wall)
    }
    
    func removeWall(_ wall: Wall) {
        walls.remove(wall)
    }
    
    func setWall(_ wall: Wall) {
        walls.insert(wall)
    }
}
