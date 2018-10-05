//
//  Button.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 03.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

class Button: Control {
    var text: String? {
        didSet { updateLabelSize() }
    }
    var fontSize: CGFloat = 16 {
        didSet { updateLabelSize() }
    }
    var fontPadding: UIEdgeInsets = .zero {
        didSet { updateLabelSize() }
    }

        
    private(set) var label: SKLabelNode
    
    init(text: String? = nil, defaultColor: SKColor, highlightedColor: SKColor, size: CGSize, cornerRadius: CGFloat = 5) {
        label = SKLabelNode(text: text)
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.fontSize = fontSize
        self.text = text
        
        super.init(defaultColor: defaultColor, highlightedColor: highlightedColor, size: size, cornerRadius: cornerRadius)
        
        isUserInteractionEnabled = true
        updateLabelSize()
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLabelSize() {
        label.text = text
        label.fontSize = fontSize
        let scalingFactor = min(frame.width / (label.frame.width + fontPadding.left + fontPadding.right), frame.height / (label.frame.height + fontPadding.top + fontPadding.bottom))
        if scalingFactor < 1 {
            label.fontSize *= scalingFactor
        }
    }
}
