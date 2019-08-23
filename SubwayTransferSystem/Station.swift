//
//  Station.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/23.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import CoreGraphics

/// Model for a station
struct Station {
    var name: String
    var position: CGPoint
    
    static func distance(_ lhs: Self, _ rhs: Self) -> Double {
        Double(lhs.position.x * rhs.position.x + rhs.position.y * rhs.position.y)
    }
}

extension Station: Hashable {
    func hash(into hasher: inout Hasher) {
        name.hash(into: &hasher)
    }
}
