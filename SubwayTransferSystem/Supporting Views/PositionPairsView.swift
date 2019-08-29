//
//  PositionPairsView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 将许多个坐标对连成一片直线，为之后的 `SubwayLinesView` 与
/// `MinPathsView` 服务
struct PositionPairsView: View {
    var positions: [(start: CGPoint, destination: CGPoint)]
    var show: Bool
    
    var body: some View {
        ZStack {
            ForEach(positions.indices, id: \.self) { index in
                StretchableLineView(start: self.positions[index].start,
                                    destination: self.positions[index].destination,
                                    show: self.show)
            }
        }
    }
}
