//
//  MinPathPickerSection.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

struct MinPathPickerSection: View {
    var stations: [Station]
    
    @Binding var start: Int
    @Binding var destination: Int
    @Binding var showRecommendedRoutes: Bool
    
    
    var body: some View {
        Section(header: Text("最优路径")) {
            StringPicker(title: "起点", content: stations.map { $0.name }, selectedIndex: $start)
            StringPicker(title: "终点", content: stations.map { $0.name }, selectedIndex: $destination)
            Toggle(isOn: $showRecommendedRoutes) { Text("显示最优路径") }
        }
    }
}
