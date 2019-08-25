//
//  StationPickerView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

struct StationPickerView: View {
    var stations: [Station]
    
    @Binding var start: Int
    @Binding var destination: Int
    
    var body: some View {
        Form {
            NavigationLink("起点", destination: picker(for: $start))
            NavigationLink("终点", destination: picker(for: $destination))
        }
    }
    
    func picker(for index: Binding<Int>) -> some View {
        Picker("", selection: index) {
            ForEach(stationIndices, id: \.self) { index in
                Text(self.stations[index].name)
            }
        }
    }
    
}

private extension StationPickerView {
    var stationIndices: Range<Int> { 0..<stations.count }
}
