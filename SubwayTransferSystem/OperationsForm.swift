//
//  OperationsForm.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 用户可以进行选择操作的表单
struct OperationsForm: View {
    @Binding var model: SubwayTransferSystem
    
    var body: some View {
        Form {
            Section(header: Text("新增站点")) {
                TextField("新增的站点名", text: $model.newStation.name)
            }
            
            StationPickerSection(stations: model.graph.vertices,
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
