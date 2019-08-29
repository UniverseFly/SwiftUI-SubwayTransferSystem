//
//  OperationsForm.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 表示用户可以进行选择操作的表单
struct OperationsForm: View {
    @ObservedObject var model: SubwayTransferSystem
    
    var body: some View {
        Form {
            Section(header: Text("改变大小")) {
                Slider(value: $model.scale, in: 0...1.5)
            }
            Section(header: Text("改变 x 轴偏移量")) {
                Slider(value: $model.offset.x, in: -1000...1000)
            }
            Section(header: Text("改变 y 轴偏移量")) {
                Slider(value: $model.offset.y, in: -1000...1000)
            }

            Section(header: Text("新增站点")) {
                TextField("新增的站点名", text: $model.newStation.name)
            }
            
            NewSubwayLinePickerSection(stations: model.graph.vertices,
                                 start: $model.newSubwayLineStartIndex,
                                 destination: $model.newSubwayLineDestIndex,
                                 action: { self.model.addSubwayLine() })
            
            MinPathPickerSection(stations: model.graph.vertices,
                                 start: $model.minPathStartIndex,
                                 destination: $model.minPathDestIndex,
                                 showRecommendedRoutes: $model.showRecommendedRoutes)
            
            AppUIOptionsSection(showSubwayLines: $model.showSubwayLines)
        }
    }
}
