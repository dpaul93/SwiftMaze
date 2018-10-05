//
//  ScaleFactor.swift
//  SwiftMaze
//
//  Created by Pavlo Deynega on 04.10.2018.
//  Copyright © 2018 Pavlo Deynega. All rights reserved.
//

import UIKit

struct ScaleFactor {
    static private let defaultSize = CGSize(width: 375, height: 667)
    static var screen: CGSize { return UIScreen.main.bounds.size }
    static var screenHalved: CGSize { return CGSize(width: screen.width / 2, height: screen.height / 2) }
    static var width: CGFloat { return UIScreen.main.bounds.width / defaultSize.width }
    static var height: CGFloat { return UIScreen.main.bounds.height / defaultSize.height }
}
