//
//  Field.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import CoreGraphics

class Field {
    let cells: [[Cell]]
    var size: Size {
        return Size(width: cells.count, height: cells.first?.count ?? 0)
    }
    
    init(cells: [[Cell]]) {
        self.cells = cells
    }
}

extension Field {
    func neighborsOfCell(_ cell: Cell) -> [Cell] {
        let position = cell.position
        
        let positionMap = [
            Position(x:position.x - 1, y: position.y),
            Position(x:position.x + 1, y: position.y),
            Position(x:position.x, y: position.y - 1),
            Position(x:position.x, y: position.y + 1)
        ]
        let neighbors = positionMap.compactMap { currentPosition in
            return
                isValidPosition(currentPosition) ?
                cells[safe: currentPosition.x]?[safe: currentPosition.y] :
                nil
        }
        
        return neighbors
    }
    
    private func isValidPosition(_ position: Position) -> Bool {
        return
            position.x >= 0 &&
            position.x < size.width &&
            position.y >= 0 &&
            position.y < size.height
    }
}
