//
//  StationsView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 只用来显示所有的站点以及添加站点，与线路无关，
/// 通过拖拽可以增减站点
struct StationsView: View {
    @ObservedObject var model: SubwayTransferSystem
    
    var body: some View {
        ForEach(model.graph.vertices.indices, id: \.self) { index in
            VertexView(name: self.model.graph.vertices[index].name)
                .position(self.model.graph.vertices[index].position)
                .gesture(DragGesture().onEnded { value in
                    self.model.newStation.position = value.location
                    self.model.addStation()
                })
        }
    }
}
