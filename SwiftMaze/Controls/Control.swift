//
//  Control.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 03.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

protocol ControlDelegate: class {
    func didSelect(_ control: Control)
}

class Control: SKShapeNode {
    weak var delegate: ControlDelegate?
    
    var defaultColor: SKColor?
    var highlightedColor: SKColor?
    
    init(defaultColor: SKColor, highlightedColor: SKColor, size: CGSize, cornerRadius: CGFloat = 5) {
        self.defaultColor = defaultColor
        self.highlightedColor = highlightedColor
        super.init()
        fillColor = defaultColor
        strokeColor = defaultColor
        path = CGPath(roundedRect: CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size), cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        highlightedColor.flatMap { fillColor = $0 }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first, let parent = self.parent else { return }
        
        if frame.contains(touch.location(in: parent)) {
            highlightedColor.flatMap { fillColor = $0 }
        } else {
            defaultColor.flatMap { fillColor = $0 }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        defaultColor.flatMap { fillColor = $0 }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        defaultColor.flatMap { fillColor = $0 }
        guard let touch = touches.first, let parent = self.parent else { return }
        
        if frame.contains(touch.location(in: parent)) {
            delegate?.didSelect(self)
        }
    }
}
