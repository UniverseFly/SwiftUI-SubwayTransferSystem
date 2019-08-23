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
    var body: some View {
        Circle()
            .foregroundColor(Color.gray)
            .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
            .shadow(radius: 2.5)
            .frame(width: 15, height: 15)
    }
}

struct VertexView_Previews: PreviewProvider {
    static var previews: some View {
        VertexView()
    }
}
