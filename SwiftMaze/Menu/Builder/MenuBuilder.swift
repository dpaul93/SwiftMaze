//
//  MenuBuilder.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 03.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

// MARK: - Protocol

protocol MenuBuilder {
    func buildBackground() -> SKSpriteNode
    func buildDecreaseButton() -> Button
    func buildIncreaseButton() -> Button
    func buildGenerateButton() -> Button
    func buildCounterLabel() -> SKLabelNode
}

// MARK: - Implementation

private class BaseMenuBuilder: MenuBuilder {
    let attributesBuilder: MenuAttributesBuilder
    
    init(attributesBuilder: MenuAttributesBuilder) {
        self.attributesBuilder = attributesBuilder
    }

    func buildBackground() -> SKSpriteNode {
        let attributes = attributesBuilder.buildBackground()
        
        let background = SKSpriteNode(color: attributes.backgroundColor, size: attributes.size)
        background.position = attributes.position
        
        return background
    }
    
    func buildDecreaseButton() -> Button {
        return buildButton(with: attributesBuilder.buildDecreaseButtonAttributes())
    }
    
    func buildIncreaseButton() -> Button {
        return buildButton(with: attributesBuilder.buildIncreaseButtonAttributes())
    }
    
    func buildGenerateButton() -> Button {
        return buildButton(with: attributesBuilder.buildGenerateButtonAttributes())
    }
    
    func buildCounterLabel() -> SKLabelNode {
        let attributes = attributesBuilder.buildCounterLabelAttributes()
        
        let label = SKLabelNode(fontNamed: attributes.fontName)
        label.fontColor = attributes.textColor
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = attributes.position
        label.fontSize = attributes.fontSize
        
        return label
    }
    
    func buildButton(with attributes: MenuButtonAttributes) -> Button {
        let button = Button(text: attributes.text, defaultColor: attributes.defaultColor, highlightedColor: attributes.highlightedColor, size: attributes.size)
        
        button.position = attributes.position
        button.label.fontColor = attributes.textColor
        button.label.fontName = attributes.fontName
        button.fontSize = attributes.fontSize
        button.fontPadding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        return button
    }
}

// MARK: - Factory

class MenuBuilderFactory {
    static func `default`(attributesBuilder: MenuAttributesBuilder) -> MenuBuilder {
        return BaseMenuBuilder(attributesBuilder: attributesBuilder)
    }
}
