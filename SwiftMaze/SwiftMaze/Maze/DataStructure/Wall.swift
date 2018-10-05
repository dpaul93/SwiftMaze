//
//  Wall.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import Foundation

struct Wall: OptionSet {
    var rawValue: uint_fast8_t
    
    static let up = Wall(rawValue: 1 << 0)
    static let right = Wall(rawValue: 1 << 1)
    static let down = Wall(rawValue: 1 << 2)
    static let left = Wall(rawValue: 1 << 3)
}

extension Wall {
    init() {
        self.rawValue = Wall.up.rawValue | Wall.right.rawValue | Wall.down.rawValue | Wall.left.rawValue
    }
    
    static func oppositeToWall(_ wall: Wall) -> Wall {
        switch wall {
        case .up: return .down
        case .right: return .left
        case .down: return .up
        case .left: return .right
            
        default: return Wall()
        }
    }
}


