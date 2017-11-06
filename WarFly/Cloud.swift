//
//  Cloud.swift
//  WarFly
//
//  Created by гость on 05.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import GameplayKit



final class Cloud: SKSpriteNode, GameBackgroundSpritable {

    
    static func populate(at point: CGPoint?) -> Cloud {
        let ImageName = configureName()
        let cloud = Cloud(imageNamed: ImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.zPosition = 10
        cloud.name = "sprite"
        cloud.run(move(from: cloud.position))
        
        
        return cloud
        
    }


    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = distribution.nextInt()
        let imageName    = "cl" + "\(randomNumber)"

        return imageName
    }

    static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 7, highestValue: 18)
        let randomNumber = CGFloat(distribution.nextInt()) / 10

        return randomNumber
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {

        let distance           = point.y + 100
        let moveSpeed: CGFloat = 150.0
        let duration           = distance / moveSpeed
        let move               = SKAction.move(to: CGPoint(x: point.x, y: -100), duration: TimeInterval(duration))
        return move
    }
    
    
    
    
    
    
    
    
    
    
    
}
