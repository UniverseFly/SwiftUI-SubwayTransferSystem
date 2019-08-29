//
//  MinPathsView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 用红色覆盖显示最短路径线路
struct MinPathsView: View {
    @ObservedObject var model: SubwayTransferSystem
    
    var body: some View {
        PositionPairsView(positions: model.minPath, show: model.showRecommendedRoutes)
            .foregroundColor(Color.red)
    }
}
