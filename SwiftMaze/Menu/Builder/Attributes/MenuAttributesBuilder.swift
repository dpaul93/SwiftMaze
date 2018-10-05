//
//  MenuAttributesBuilder.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 04.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import SpriteKit

private enum ControlSizes {
    case amount, generate, background, counter
    
    func size() -> CGSize {
        switch self {
        case .amount: return CGSize(width: 25, height: 25)
        case .generate: return CGSize(width: 60, height: 25)
        case .background: return CGSize(width: ScaleFactor.screen.width, height: 60)
        case .counter: return CGSize(width: 40, height: 60)
        }
    }
}

// MARK: - Protocol

protocol MenuAttributesBuilder {
    func buildBackground() -> MenuBackgroundAttributes
    func buildDecreaseButtonAttributes() -> MenuButtonAttributes
    func buildIncreaseButtonAttributes() -> MenuButtonAttributes
    func buildGenerateButtonAttributes() -> MenuButtonAttributes
    func buildCounterLabelAttributes() -> MenuLabelAttributes
}

// MARK: - Implementation

private class BaseMenuAttributesBuilder: MenuAttributesBuilder {
    func buildBackground() -> MenuBackgroundAttributes {
        let height = ScaleFactor.height * ControlSizes.background.size().height
        return DefaultMenuBackgroundAttributes(
            backgroundColor: UIColor(rgb: 0x266782),
            size: CGSize(width: ScaleFactor.screen.width,height: height),
            position: CGPoint(x: 0, y: ScaleFactor.screenHalved.height - height / 2))
    }
    
    func buildDecreaseButtonAttributes() -> MenuButtonAttributes {
        let buttonSize = ControlSizes.amount.size().height
        let size = CGSize(width: ScaleFactor.width * buttonSize, height: ScaleFactor.height * buttonSize)
        return buildButton(
            with: "-",
            size: size,
            position: CGPoint(x: ScaleFactor.width * 10 - ScaleFactor.screenHalved.width + size.width / 2, y: -ScaleFactor.height * size.height / 2))
    }
    
    func buildIncreaseButtonAttributes() -> MenuButtonAttributes {
        let buttonSize = ControlSizes.amount.size().height
        let size = CGSize(width: ScaleFactor.width * buttonSize, height: ScaleFactor.height * buttonSize)
        let xPos = ControlSizes.amount.size().width + 10 + ControlSizes.counter.size().width + size.width / 2
        return buildButton(
            with: "+",
            size: size,
            position: CGPoint(x: ScaleFactor.width * xPos - ScaleFactor.screenHalved.width, y: -ScaleFactor.height * size.height / 2))
    }
    
    func buildGenerateButtonAttributes() -> MenuButtonAttributes {
        let size = CGSize(
            width: ScaleFactor.width * ControlSizes.generate.size().width,
            height: ScaleFactor.height * ControlSizes.generate.size().height)
        return buildButton(
            with: "Generate",
            size: size,
            position: CGPoint(x: ScaleFactor.screenHalved.width - 10 * ScaleFactor.width - size.width / 2, y: -ScaleFactor.height * size.height / 2))
    }
    
    func buildCounterLabelAttributes() -> MenuLabelAttributes {
        let height = ScaleFactor.height * ControlSizes.counter.size().height
        let xPos = ControlSizes.amount.size().width + 10 + ControlSizes.counter.size().width / 2
        return DefaultMenuLabelAttributes(
            fontSize: 20,
            textColor: UIColor(rgb: 0xeaeaea),
            fontName: "AppleSDGothicNeo-Medium",
            size: CGSize(width: ScaleFactor.width * ControlSizes.counter.size().width, height: height),
            position: CGPoint(x: ScaleFactor.width * xPos - ScaleFactor.screenHalved.width, y: -height / 4))
    }
    
    func buildButton(with text: String, size: CGSize, position: CGPoint) -> MenuButtonAttributes {
        return DefaultMenuButtonAttributes(
            fontSize: 16,
            textColor: .white,
            fontName: "AppleSDGothicNeo-Medium",
            defaultColor: UIColor(rgb: 0x0099bf).withAlphaComponent(0.6),
            highlightedColor: UIColor(rgb: 0x0099bf),
            text: text,
            size: size,
            position: position)
    }
}

// MARK: - Factory

class MenuAttributesBuilderFactory {
    static func `default`() -> MenuAttributesBuilder {
        return BaseMenuAttributesBuilder()
    }
}
