//
//  YellowShot.swift
//  WarFly
//
//  Created by гость on 10.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import SpriteKit

class YellowShot: Shot {

    init() {
        let textureAtlas = Assets.shared.yellowShotAtlas //SKTextureAtlas(named: "YellowShot")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
