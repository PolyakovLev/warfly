//
//  BluePowerUP.swift
//  WarFly
//
//  Created by гость on 10.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit

class BluePowerUp: PowerUp {
    init() {
        let textureAtlas = Assets.shared.bluePowerUpAtlas //SKTextureAtlas(named: "BluePowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
