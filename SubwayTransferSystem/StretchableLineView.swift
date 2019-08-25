//
//  StretchableLineView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 这条直线可以在出现时、按钮控制时显示伸缩动画
///
/// To render the line view:
///
/// ```
/// ScalableLineView(start: .., destination: ...)
///     .foreGroundColor(Color.red)
/// ```
struct StretchableLineView: View {
    var start: CGPoint
    var destination: CGPoint
    var show: Bool
    
    /// 这是个精髓，有了它才做到了出现时的动画
    @State var appeared = false
    
    var body: some View {
        Line(ratio: appeared && show ? 1 : 0, start: start, destination: destination)
            .stroke(lineWidth: 3.3)
            .animation(.easeInOut(duration: 1.5))
            .onAppear { self.appeared = true }
    }
}

/// 一个可以根据比例缩放且产生动画效果的直线，为 `ScalableLineView` 服务
private struct Line: Shape {
    var ratio: CGFloat
    var start: CGPoint
    var destination: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: start)
        p.addLine(to: CGPoint(x: start.x + ratio * (destination.x - start.x),
                              y: start.y + ratio * (destination.y - start.y)))
        return p
    }
    
    var animatableData: CGFloat {
        get { return ratio }
        set { ratio = newValue }
    }
}
