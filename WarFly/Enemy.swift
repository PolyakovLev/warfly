//
//  Enemy.swift
//  WarFly
//
//  Created by гость on 07.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    
    init(enemyTexture: SKTexture) {
        
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5 // переворачивает самолет врага
        self.name = "sprite"
        self.zPosition = 20
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy
        self.physicsBody?.collisionBitMask = BitMaskCategory.player | BitMaskCategory.shot
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player | BitMaskCategory.shot

        
    }
    
    
    func flySpiral() {
        
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double = 10
        
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        let rundomNumber = Int(arc4random_uniform(2))
        // MARK: присваивание через тернарный оператор
        let asideMovementSequence =  rundomNumber == enemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
        
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func kill() {
        let blink = SKAction.animate(with: [enemyTexture], timePerFrame: 0.5, resize: true, restore: false)
    }
}

enum enemyDirection: Int {
    case left = 0
    case right
}
















