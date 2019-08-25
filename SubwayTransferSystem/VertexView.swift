//
//  VertexView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/23.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 每个地铁站点的节点
struct VertexView: View {
    var name: String
    @State private var showDetail = false
    
    var body: some View {
        VStack(spacing: 5) {
            if (showDetail) { Text(name).padding(5).background(Color.gray.opacity(0.4))
            }
            Circle()
                .foregroundColor(Color.gray)
                .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
                .shadow(radius: 2.5)
                .frame(width: 15, height: 15)
        }
        .onLongPressGesture {
            withAnimation { self.showDetail.toggle() }
        }
    }
}
