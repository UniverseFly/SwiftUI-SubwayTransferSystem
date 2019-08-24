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
    
    /// 站点名到它所在下标的 map
    var stationToIndex = [String: Int]()
    
    mutating func addStation(_ station: Station) {
        vertices.append(station)
        stationToIndex[station.name] = vertices.count - 1
    }
    
    mutating func addSubwayLine(from start: String, to destination: String) {
        guard let startIndex = stationToIndex[start], let destIndex = stationToIndex[destination]
            else { return }
        
        if (arcs[startIndex] == nil) { arcs[startIndex] = Set() }
        let startStation = vertices[startIndex], destStation = vertices[destIndex]
        
        let node = ArcNode(index: destIndex, distance: Station.distance(startStation, destStation))
        arcs[startIndex]!.insert(node)
    }
}
