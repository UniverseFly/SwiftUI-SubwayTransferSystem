//
//  StationsView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/25.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 只用来显示所有的站点以及添加站点，与线路无关
struct StationsView: View {
    var stations: [Station]
    
    var body: some View {
        ForEach(stationIndices, id: \.self) { index in
            VertexView(name: self.stations[index].name)
                .position(self.stations[index].position)
        }
    }
}

private extension StationsView {
    var stationIndices: Range<Int> { 0..<stations.count }
}
