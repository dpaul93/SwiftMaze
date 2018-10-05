//
//  MazeBuilder.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 28.09.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol MazeBuilder {
    init(algorithm: MazeAlgorithm, generator: MazeGenerator)
    
    func generate() -> Field
}

// MARK: - Implementation

private class BaseMazeBuilder: MazeBuilder {
    let algorithm: MazeAlgorithm
    let generator: MazeGenerator
    
    required init(algorithm: MazeAlgorithm, generator: MazeGenerator) {
        self.algorithm = algorithm
        self.generator = generator
    }
    
    // MARK: – MazeBuilder

    func generate() -> Field {
        let field = generator.generate()
        let maze = algorithm.generate(with: field)
        
        return maze
    }
}

// MARK: - Factory

class MazeBuilderFactory {
    static func `default`(
        algorithm: MazeAlgorithm,
        generator: MazeGenerator
    ) -> MazeBuilder {
        return BaseMazeBuilder(algorithm: algorithm, generator: generator)
    }
}
