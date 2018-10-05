//
//  Menu.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 04.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

protocol MenuDelegate: class {
    func handleGenerate(with dimension: Int)
}

// MARK: - Protocol

protocol Menu {
    var background: SKSpriteNode { get }
    var delegate: MenuDelegate? { get set }
}

// MARK: - Implementation

private class BaseMenu: Menu {
    weak var delegate: MenuDelegate?
    
    let builder: MenuBuilder
    var mazeDimensions: Int = 0 {
        didSet { counterLabel.text = "\(mazeDimensions)" }
    }

    var background: SKSpriteNode
    var counterLabel: SKLabelNode!
    var decreaseButton: Button!
    var increaseButton: Button!
    var generateButton: Button!
    
    init(builder: MenuBuilder) {
        self.builder = builder
        background = builder.buildBackground()

        initControls()
    }
    
    func initControls() {
        counterLabel = builder.buildCounterLabel()
        mazeDimensions = 5
        background.addChild(counterLabel)
        decreaseButton = builder.buildDecreaseButton()
        increaseButton = builder.buildIncreaseButton()
        generateButton = builder.buildGenerateButton()
        
        [decreaseButton, increaseButton, generateButton].forEach {
            $0?.delegate = self
            $0.flatMap { background.addChild($0) }
        }
    }
}

extension BaseMenu: ControlDelegate {
    func didSelect(_ control: Control) {
        switch control {
        case decreaseButton: updateCounter(with: -1)
        case increaseButton: updateCounter(with: 1)
        case generateButton: delegate?.handleGenerate(with: mazeDimensions)
        default: break
        }
    }
    
    func updateCounter(with value: Int) {
        mazeDimensions = max(0, mazeDimensions + value)
    }
}

// MARK: - Factory

class MenuFactory {
    static func `default`(builder: MenuBuilder = MenuBuilderFactory.default(attributesBuilder: MenuAttributesBuilderFactory.default())) -> Menu {
        return BaseMenu(builder: builder)
    }
}
