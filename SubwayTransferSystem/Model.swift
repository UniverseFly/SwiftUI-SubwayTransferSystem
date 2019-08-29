//
//  Model.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import CoreGraphics

/// The view model for the whole app
struct SubwayTransferSystem {
    /// 地铁图模型
    private(set) var graph: SubwayGraph
    
    /// 最短路径的起始于目的下标
    var minPathStartIndex = 0
    var minPathDestIndex = 1
    
    /// 是否显示地铁线路与推荐线路
    var showSubwayLines = true
    var showRecommendedRoutes = false
    
    /// 要添加的新站点
    var newStation = Station(name: "", position: .init(x: 0, y: 0))
    
    /// 要添加的地铁线路的开始与目的下标
    var newSubwayLineStartIndex = 0
    var newSubwayLineDestIndex = 1
    
    /// 根据 `minPathStartIndex` 和 `minPathDestIndex` 返回最短路径
    var minPath: [(CGPoint, CGPoint)] {
        if minPathStartIndex < 0 || minPathStartIndex >= graph.vertices.count { return [] }
        if minPathDestIndex < 0 || minPathDestIndex >= graph.vertices.count { return [] }
        
        let start = graph.vertices[minPathStartIndex].name
        let destination = graph.vertices[minPathDestIndex].name
        
        return graph.minPath(from: start, to: destination)
    }
    
    /// 根据 `newStation` 对内部的图进行操作增加站点
    mutating func addStation() {
        graph.addStation(newStation)
    }
    
    /// 根据 `newSubwayLineStartIndex` 和 `newSubwayLineStartIndex` 添加线路
    mutating func addSubwayLine() {
        let start = graph.vertices[newSubwayLineStartIndex].name
        let destination = graph.vertices[newSubwayLineDestIndex].name
        graph.addSubwayLine(from: start, to: destination)
        graph.addSubwayLine(from: destination, to: start)
    }
}
