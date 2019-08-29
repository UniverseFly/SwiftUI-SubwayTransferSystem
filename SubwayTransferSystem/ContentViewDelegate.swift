//
//  ContentViewDelegate.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import CoreGraphics
import Combine

/// 接管 `ContentView` 中的部分属性，避免了 Crash。原因未知
class ContentViewDelegate: ObservableObject {
    @Published var offset: (x: CGFloat, y: CGFloat) = (x: 0, y: 0)
    @Published var scale: CGFloat = 1.0
}
