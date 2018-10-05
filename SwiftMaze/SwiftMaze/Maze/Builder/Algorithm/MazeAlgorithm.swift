//
//  MazeAlgorithm.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol MazeAlgorithm {
    func generate(with field: Field) -> Field
}

// MARK: - Implementation

enum DepthFirstMazeType {
    case random, horizontal, vertical
}

private class DepthFirstMazeAlgorithm: MazeAlgorithm {
    let type: DepthFirstMazeType
    var visitedMap: [[Bool]] = [[]]
    var stack: [Cell] = []
    
    init(type: DepthFirstMazeType) {
        self.type = type
    }
    
    // MARK: – MazeAlgorithm
    
    func generate(with field: Field) -> Field {
        let size = field.size
        visitedMap = Array(repeating: Array(repeating: false, count: size.height), count: size.width)
        
        guard var currentCell = field.cells.first?.first else { return field }
        currentCell.removeWall(.down)
        stack.append(currentCell)
        visitedMap[safe: 0]?[safe: 0] = true
        
        var visitedCount = 1
        let cellCount = size.width * size.height
        
        while visitedCount < cellCount {
            let neighbors = unvisitedNeighbors(of: currentCell, fromField: field)
            
            guard neighbors.count > 0 else {
                currentCell = stack.removeLast()
                continue
            }
            
            guard let randomCell = randomElement(from: neighbors) else { continue }
            visitedMap[safe: randomCell.position.x]?[safe: randomCell.position.y] = true
            knockWallBetween(first: currentCell, second: randomCell)
            stack.append(randomCell)
            currentCell = randomCell
            visitedCount += 1
        }
        
        field.cells.last?.last?.removeWall(.up)
        
        return field
    }
    
    func randomElement(from sequence: [Cell]) -> Cell? {
        let n: Double = 1000
        let probability = 0.6
        if arc4random_uniform(UInt32(n)) < UInt32(n * probability) {
            if type == .horizontal {
                return sequence.first
            } else if type == .vertical {
                return sequence.last
            }
        }

        return sequence.randomElement()
    }
    
    func unvisitedNeighbors(of cell: Cell, fromField field: Field) -> [Cell] {
        let neighbors = field.neighborsOfCell(cell)
        
        return neighbors.compactMap {
            let position = $0.position
            return visitedMap[safe: position.x]?[safe: position.y] == false ? $0 : nil
        }
    }
    
    func knockWallBetween(first: Cell, second: Cell) {
        let direction = directionBetween(first: first, second: second)
        let opposite = Wall.oppositeToWall(direction)
        
        first.removeWall(direction)
        second.removeWall(opposite)
    }
    
    func directionBetween(first: Cell, second: Cell) -> Wall {
        let firstPosition = first.position
        let secondPosition = second.position
        
        if firstPosition.x < secondPosition.x {
            return Wall.right
        } else if firstPosition.x > secondPosition.x {
            return Wall.left
        } else if firstPosition.y < secondPosition.y {
            return Wall.up
        } else if firstPosition.y > secondPosition.y {
            return Wall.down
        } else {
            return Wall()
        }
    }
}

// MARK: - Factory

class MazeAlgorithmFactory {
    static func depthFirstMazeAlgorithm(type: DepthFirstMazeType = .random) -> MazeAlgorithm {
        return DepthFirstMazeAlgorithm(type: type)
    }
}

