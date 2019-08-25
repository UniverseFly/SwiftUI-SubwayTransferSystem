//
//  SubwayLinesView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 管控整个地铁线路的显示与否，与站点无关
struct SubwayLinesView: View {
    var positions: [(start: CGPoint, destination: CGPoint)]
    var show: Bool
    
    var body: some View {
        ZStack {
            ForEach(positionIndices, id: \.self) { index in
                StretchableLineView(start: self.positions[index].start,
                                    destination: self.positions[index].destination,
                                    show: self.show)
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

private extension SubwayLinesView {
    var positionIndices: Range<Int> { 0..<positions.count }
}
