//
//  MazeDrawer.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 02.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

// MARK: - Protocol

protocol MazeDrawer {
    init(field: Field, cellSize: CGFloat, wallSize: CGFloat)
    
    func draw() -> MazeNode
}

// MARK: - Implementation

private class BaseMazeDrawer: MazeDrawer {
    let field: Field
    let wallColor: SKColor = .gray
    let backgroundColor: SKColor = .lightGray
    
    let cellSize: CGFloat
    let wallSize: CGFloat
    
    required init( field: Field, cellSize: CGFloat, wallSize: CGFloat) {
        self.field = field
        self.cellSize = cellSize
        self.wallSize = wallSize
    }
    
    // MARK: – MazeDrawer
    
    func draw() -> MazeNode {
        let containerNode = MazeNode(color: backgroundColor, size: CGSize(width: field.size.cgSize.width * cellSize, height: field.size.cgSize.height * cellSize))
        containerNode.anchorPoint = CGPoint.zero
        
        field.cells.flatMap { $0 }.forEach { cell in
            let cellNode = drawCell(cell)
            cellNode.position.x -= containerNode.size.width / 2
            cellNode.position.y -= containerNode.size.height / 2
            containerNode.addChild(cellNode)
        }
        
        containerNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        return containerNode
    }
    
    func drawCell(_ cell: Cell) -> SKSpriteNode {
        let cellNode = SKSpriteNode(color: .clear, size: CGSize(width: cellSize, height: cellSize))
        cellNode.position = centerPosition(for: cell)
        
        if cell.containsWall(.up) {
            cellNode.addChild(drawWall(.up))
        }
        if cell.containsWall(.right) {
            cellNode.addChild(drawWall(.right))
        }
        if cell.containsWall(.down) {
            cellNode.addChild(drawWall(.down))
        }
        if cell.containsWall(.left) {
            cellNode.addChild(drawWall(.left))
        }
        
        return cellNode
    }
    
    func drawWall(_ wall: Wall) -> SKSpriteNode {
        var position = CGPoint.zero
        // TODO: fix size overlap
        let size = CGSize(
            width: wall.contains(.up) || wall.contains(.down) ? cellSize: wallSize,
            height: wall.contains(.left) || wall.contains(.right) ? cellSize : wallSize)

        if wall.contains(.up) {
            position.y += cellSize / 2 //+ size.height / 2
        } else if wall.contains(.right) {
            position.x += cellSize / 2// + size.width / 2
        } else if wall.contains(.down) {
            position.y -= cellSize / 2// - size.height / 2
        } else if wall.contains(.left) {
            position.x -= cellSize / 2// + size.width / 2
        }
        
        let wallNode = SKSpriteNode(color: wallColor, size: size)
        wallNode.position = position
        
        return wallNode
    }
    
    func centerPosition(for cell: Cell) -> CGPoint {
        return CGPoint(
            x: CGFloat(cell.position.x) * cellSize + cellSize / 2,
            y: CGFloat(cell.position.y) * cellSize + cellSize / 2
        )
    }
}

// MARK: - Factory

class MazeDrawerFactory {
    static func `default`(
        field: Field,
        cellSize: CGFloat = 30,
        wallScaleFactor: CGFloat = 0.2
    ) -> MazeDrawer {
        return BaseMazeDrawer(field: field, cellSize: cellSize, wallSize: cellSize * wallScaleFactor)
    }
}
