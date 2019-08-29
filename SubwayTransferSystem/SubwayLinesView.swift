//
//  SubwayLinesView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 用黄色显示所有的地铁线路
struct SubwayLinesView: View {
    var model: SubwayTransferSystem
    
    var body: some View {
        PositionPairsView(positions: model.graph.subwayLines, show: model.showSubwayLines)
            .foregroundColor(Color.yellow)
    }
}
