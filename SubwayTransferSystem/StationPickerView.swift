//
//  StationPickerView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 选择所乘地铁的起点和终点
///
/// 把 `Picker` 放在 `Form` 下会产生神奇的效果
///
/// # Reference
///
/// https://fuckingswiftui.com/#picker
struct StationPickerView: View {
    var stations: [Station]
    
    @Binding var start: Int
    @Binding var destination: Int
    
    let action: () -> Void
    
    init(stations: [Station], start: Binding<Int>,
         destination: Binding<Int>, action: @escaping () -> ()) {
        self.stations = stations
        self._start = start
        self._destination = destination
        self.action = action
    }
    
    var body: some View {
        Section(header: Text("选择起点与终点")) {
            picker("起点", for: $start)
            picker("终点", for: $destination)
            Button(action: action) { Text("添加线路") }
        }
    }
    
    private func picker(_ title: String, for index: Binding<Int>) -> some View {
        Picker(title, selection: index) {
            ForEach(stationIndices, id: \.self) { index in
                Text(self.stations[index].name)
            }
        }
    }
}

private extension StationPickerView {
    var stationIndices: Range<Int> { 0..<stations.count }
}
