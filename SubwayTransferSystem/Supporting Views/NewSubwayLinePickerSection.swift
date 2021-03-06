//
//  NewSubwayLinePickerSection.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 选择添加线路的起点和终点
///
/// 把 `Picker` 放在 `Form` 下会产生神奇的效果
///
/// # Reference
///
/// https://fuckingswiftui.com/#picker
struct NewSubwayLinePickerSection: View {
    var stations: [Station]
    
    @Binding var start: Int
    @Binding var destination: Int
    
    let action: () -> Void
    
    var body: some View {
        Section(header: Text("添加新线路")) {
            StringPicker(title: "起点", content: stations.map { $0.name }, selectedIndex: $start)
            StringPicker(title: "终点", content: stations.map { $0.name }, selectedIndex: $destination)
            Button(action: action) { Text("添加线路") }
        }
    }
}
