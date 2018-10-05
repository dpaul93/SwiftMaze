//
//  DataStructures.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import CoreGraphics

struct Position {
    let x: Int
    let y: Int
}

struct Size {
    let width: Int
    let height: Int
}

extension Size {
    var cgSize: CGSize {
        return CGSize(width: self.width, height: self.height)
    }
    
    static var zero: Size {
        return Size(width: 0, height: 0)
    }
}
