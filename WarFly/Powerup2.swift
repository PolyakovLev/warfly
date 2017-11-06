//
//  PowerApp.swift
//  WarFly
//
//  Created by гость on 06.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import GameplayKit
import SpriteKit

class PowerUp2: SKSpriteNode {
    
    var textureAnimationArray = [SKTexture]()
    
    static func populate(at point: CGPoint?) -> PowerUp2 {
        let powerApp = PowerUp2(imageNamed: configureName())
        powerApp.setScale(1.0)
        powerApp.position = point ?? randomPoint()
        powerApp.zPosition = 19
        powerApp.name = "sprite"
        powerApp.run(move(from: powerApp.position))
        
        return powerApp
        
    }
    
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 15)
        let randomNumber = distribution.nextInt()
        let imageName = "missle_green_" + "\(randomNumber)"
        
        return imageName
    }
    
    
    fileprivate func powerAppAnimationFillArray() {
        
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "GreenPowerUp")]) {
            
            self.textureAnimationArray = {
                
                var array = [SKTexture]()
                for i in stride(from: 1, through: 15, by: 1) {
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "missle_green_\(number)")
                    array.append(texture)
                }
                SKTexture.preload(array, withCompletionHandler: {
                    print("Preload is done 22222")
                })
                return array
            } ()
        }
    }
    
    fileprivate func rotation() {
        powerAppAnimationFillArray()
        let rotation = SKAction.animate(with: textureAnimationArray, timePerFrame: 0.2, resize: true, restore: false)
        let unstopableRotation = SKAction.repeatForever(rotation)
        self.run(unstopableRotation)
        
    }
    
    
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.height) + 200)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y)
    }
    
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        
        let distance           = point.y + 100
        let moveSpeed: CGFloat = 100.0
        let duration           = distance / moveSpeed
        let move               = SKAction.move(to: CGPoint(x: point.x, y: -100), duration: TimeInterval(duration))
        return move
    }
    
}
