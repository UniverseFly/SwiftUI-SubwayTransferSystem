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
    @Binding var model: SubwayGraph
    @Binding var showRecommendedRoutes: Bool
    @Binding var showSubwayLines: Bool
    @Binding var startIndex_forMinPath: Int
    @Binding var destIndex_forMinPath: Int
    @Binding var newStationName: String
    
    @State private var startIndex_forAddLine: Int = 0
    @State private var destIndex_forAddLine: Int = 1
    
    
    var body: some View {
        let addSubwayLine = {
            self.model.addSubwayLine(from: self.model.vertices[self.startIndex_forAddLine].name,
                                     to: self.model.vertices[self.destIndex_forAddLine].name)
        }
        
        return Form {
            Section {
                TextField("新增的站点名", text: $newStationName)
            }
            
            StationPickerSection(stations: model.vertices, start: $startIndex_forAddLine,
                                 destination: $destIndex_forAddLine, action: addSubwayLine)
            MinPathPickerSection(stations: model.vertices, start: $startIndex_forMinPath,
                                 destination: $destIndex_forMinPath,
                                 showRecommendedRoutes: $showRecommendedRoutes)
            AppUIOptionsSection(showSubwayLines: $showSubwayLines)
        }
    }
}
