//
//  protocol GameBackgroundSriteable + Extention.swift
//  WarFly
//
//  Created by гость on 05.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpritable {
    static func populate(at point: CGPoint?) -> Self
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSpritable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.height) + 200)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
}
