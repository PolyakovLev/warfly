//
//  PlayerPlane.swift
//  WarFly
//
//  Created by гость on 05.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    let motionManager = CMMotionManager() // отслеживать повороты устройства
    var xAcceleration:CGFloat = 0 // повороты в скорость
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    var moveDerection: TurnDirection = .forward
    var stillTorning = false
    let animationSpriteStrides = [(13, 1, -1), (12, 26, 1), (13, 13, 1)]
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        let atles = Assets.shared.playerPlaneAtlas
        let playerPlaneTexture = atles.textureNamed("airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 40
        
        playerPlane.physicsBody = SKPhysicsBody(texture: playerPlaneTexture, alphaThreshold: 0.5, size: playerPlane.size)
        playerPlane.physicsBody?.isDynamic = false
        playerPlane.physicsBody?.categoryBitMask = BitMaskCategory.player
        playerPlane.physicsBody?.collisionBitMask = BitMaskCategory.enemy | BitMaskCategory.powerUp
        playerPlane.physicsBody?.contactTestBitMask = BitMaskCategory.enemy | BitMaskCategory.powerUp
        
        return playerPlane
    }
    
    func performFly() {
        
        // planeAnimationFillArray()
        preloadTextueArrays()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self]  (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
        let planeWaitAction = SKAction.wait(forDuration: 1)
        let planeDirectionCheckAction = SKAction.run { [weak self] in
            self?.movementDirectionCheck()
        }
        let planeSequence = SKAction.sequence([planeWaitAction, planeDirectionCheckAction])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
    }
    
    func cheskPosition() {
        
        self.position.x += xAcceleration * 50
        
        if self.position.x < -50 {
            self.position.x = screenSize.width + 50
        } else if self.position.x > screenSize.width + 50  {
            self.position.x = -50
        }
    }
    
    fileprivate func preloadTextueArrays() {
        for i in 0...2 {
            self.preloadArray(_stride: animationSpriteStrides[i], callback: { [unowned self] array in
                switch i {
                case 0: self.leftTextureArrayAnimation = array
                case 1: self.rightTextureArrayAnimation = array
                case 2: self.forwardTextureArrayAnimation = array
                default: break
                }
            })
        }
    }
    
    fileprivate func preloadArray(_stride: (Int, Int, Int), callback : @escaping (_ array: [SKTexture]) -> ()) {
        var array = [SKTexture]()
        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
            array.append(texture)
        }
        SKTexture.preload(array) {
            callback(array)
        }
    }
    
    //
    //    fileprivate func planeAnimationFillArray() {
    //
    //        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
    //
    //            self.leftTextureArrayAnimation = {
    //
    //                var array = [SKTexture]()
    //                for i in stride(from: 13, through: 1, by: -1) {
    //                    let number = String(format: "%02d", i)
    //                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
    //                    array.append(texture)
    //                }
    //                SKTexture.preload(array, withCompletionHandler: {
    //                    print("Preload is done ")
    //                })
    //                return array
    //            } ()
    //
    //            self.rightTextureArrayAnimation = {
    //
    //                var array = [SKTexture]()
    //                for i in stride(from: 13, through: 26, by: 1) {
    //                    let number = String(format: "%02d", i)
    //                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
    //                    array.append(texture)
    //                }
    //                SKTexture.preload(array, withCompletionHandler: {
    //                    print("Preload is done ")
    //                })
    //                return array
    //            } ()
    //
    //            self.forwardTextureArrayAnimation = {
    //
    //                var array = [SKTexture]()
    //                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
    //                array.append(texture)
    //
    //                SKTexture.preload(array, withCompletionHandler: {
    //                    print("Preload is done ")
    //                })
    //                return array
    //            } ()
    //
    //        }
    //    }
    
    fileprivate func movementDirectionCheck() {
        
        if xAcceleration > 0.02, moveDerection != .right, stillTorning == false {
            stillTorning = true
            moveDerection = .right
            turnPlane(direction: .right)
        } else if xAcceleration < -0.02, moveDerection != .left, stillTorning == false {
            stillTorning = true
            moveDerection = .left
            turnPlane(direction: .left)
        } else if stillTorning == false {
            turnPlane(direction: .forward)
        }
    }
    
    fileprivate func turnPlane(direction: TurnDirection) {
        var array = [SKTexture]()
        
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwordAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([forwardAction, backwordAction])
        self.run(sequenceAction) { [unowned self] in
            self.stillTorning = false
        }
    }
}

enum TurnDirection {
    case left
    case right
    case forward
}