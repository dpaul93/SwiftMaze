//
//  MazeGenerator.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import CoreGraphics

// MARK: - Protocol

protocol MazeGenerator {
    func generate() -> Field
}

// MARK: - Implementation

private class RectangleMazeGenerator: MazeGenerator {
    let size: Size
    
    init(size: Size) {
        self.size = size
    }
    
    // MARK: – MazeGenerator

    func generate() -> Field {
        var cells = [[Cell]]()
        
        for x in (0..<size.width) {
            var yArray = [Cell]()
            
            for y in (0..<size.height) {
                yArray.append(Cell(position: Position(x: x, y: y)))
            }
            
            cells.append(yArray)
        }
        
        return Field(cells: cells)
    }
}

// MARK: - Factory

class MazeGeneratorFactory {
    static func rectangle(size: Size) -> MazeGenerator {
        return RectangleMazeGenerator(size: size)
    }
}
