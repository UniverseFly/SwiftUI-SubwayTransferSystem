//
//  Graph.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/23.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import CoreGraphics

/// Data model for subway graph
struct SubwayGraph {
    /// 邻接边对应的顶点下标和距离
    struct ArcNode: Hashable {
        var index: Int
        var distance: Double
    }
    
    var vertices = [Station]()
    var arcs = [Int: Set<ArcNode>]()
    
    var stationToIndex = [Station: Int]()
    
    mutating func addStation(_ station: Station) {
        vertices.append(station)
        stationToIndex[station] = vertices.count - 1
    }
    
    mutating func addSubwayLine(from start: Station, to destination: Station) {
        guard let startIndex = stationToIndex[start],
            let endIndex = stationToIndex[destination]
            else { return }
        
        if (arcs[startIndex] == nil) { arcs[startIndex] = Set() }
        let node = ArcNode(index: endIndex, distance: Station.distance(start, destination))
        arcs[startIndex]!.insert(node)
    }
}
