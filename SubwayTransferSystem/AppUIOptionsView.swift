//
//  AppUIOptionsView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// App 中的 UI 交互选择，产生线路显示与消失的动画效果
struct AppUIOptionsView: View {
    @Binding var showSubwayLines: Bool
    @Binding var showRecommendedRoutes: Bool
    
    var body: some View {
        Section {
            Toggle("显示地铁线路", isOn: $showSubwayLines)
            Toggle("显示换乘信息", isOn: $showRecommendedRoutes)
        }
    }
}
