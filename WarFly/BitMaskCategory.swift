//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by гость on 10.06.17.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import Foundation

struct BitMaskCategory {
    // для масок uint32
    static let player: UInt32  = 0x1 << 0 //00000...01
    static let enemy: UInt32   = 0x1 << 1 //00000...10
    static let powerUp: UInt32 = 0x1 << 2 //00000..100
    static let shot: UInt32    = 0x1 << 3 //00000...1000

}

//struct BitMaskCategory: OptionSet {
//    let rawValue: UInt32
//    init(rawValue: UInt32) { self.rawValue = rawValue }
//    static let none    = BitMaskCategory(rawValue: 0 << 0)     // 00000...00    0
//    static let player  = BitMaskCategory(rawValue: 1 << 0)     // 00000...01    1
//    static let enemy   = BitMaskCategory(rawValue: 1 << 1)     // 00000...10    2
//    static let powerUp = BitMaskCategory(rawValue: 1 << 2)     // 00000...100   4
//    static let shot    = BitMaskCategory(rawValue: 1 << 3)     // 00000...1000  8
//    static let all     = BitMaskCategory(rawValue: UInt32.max) // 111111111111
//
//}
