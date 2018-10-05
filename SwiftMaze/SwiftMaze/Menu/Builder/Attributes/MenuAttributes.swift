//
//  MenuAttributes.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 04.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

protocol MenuAttributes {
    var size: CGSize { get }
    var position: CGPoint { get }
}

protocol MenuBackgroundAttributes: MenuAttributes {
    var backgroundColor: SKColor { get }
}

protocol MenuLabelAttributes: MenuAttributes {
    var textColor: SKColor { get }
    var fontName: String { get }
    var fontSize: CGFloat { get }
}

protocol MenuButtonAttributes: MenuLabelAttributes {
    var defaultColor: SKColor { get }
    var highlightedColor: SKColor { get }
    var text: String { get }
}

struct DefaultMenuBackgroundAttributes: MenuBackgroundAttributes {
    let backgroundColor: SKColor
    let size: CGSize
    let position: CGPoint
}

struct DefaultMenuLabelAttributes: MenuLabelAttributes {
    var fontSize: CGFloat
    let textColor: SKColor
    let fontName: String
    let size: CGSize
    let position: CGPoint
}

struct DefaultMenuButtonAttributes: MenuButtonAttributes {
    var fontSize: CGFloat
    var textColor: SKColor
    var fontName: String
    let defaultColor: SKColor
    let highlightedColor: SKColor
    let text: String
    let size: CGSize
    let position: CGPoint
}
