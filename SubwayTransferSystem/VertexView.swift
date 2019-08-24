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
        VStack(alignment: .leading, spacing: 0.5) {
            if (showDetail) { Text(name).border(Color.gray, width: 3) }
            Circle()
                .foregroundColor(Color.gray)
                .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
                .shadow(radius: 2.5)
                .frame(width: 15, height: 15)
                .onLongPressGesture {
                    withAnimation { self.showDetail.toggle() }
                }
        }.frame(width: 40, height: 40, alignment: .bottomLeading)
            .position(x: 20, y: -5).frame(width: 15, height: 15, alignment: .bottomLeading)
    }
}

//struct VertexView_Previews: PreviewProvider {
//    static var previews: some View {
//        VertexView()
//    }
//}
