//
//  Island.swift
//  WarFly
//
//  Created by Ivan Akulov on 19/04/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgroundSpritable {
    
    
    static func populate(at point: CGPoint?) -> Island {
        let ImageName = configureName()
        let island = Island(imageNamed: ImageName)
        island.setScale(randomScaleFactor)
        island.position = point ?? randomPoint()
        island.zPosition = 1
        island.name = "sprite"
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position))
        
        return island
        
    }
    
    
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNumber = distribution.nextInt()
        let imageName = "is" + "\(randomNumber)"
        
        return imageName
    }
    
    static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        
        let distance           = point.y + 100
        let moveSpeed: CGFloat = 100.0
        let duration           = distance / moveSpeed
        let move               = SKAction.move(to: CGPoint(x: point.x, y: -100), duration: TimeInterval(duration))
        return move
    }
    
}
