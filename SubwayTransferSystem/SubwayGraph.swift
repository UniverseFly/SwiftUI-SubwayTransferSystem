//
//  Graph.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/23.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import CoreGraphics

/// Data model for subway graph
struct SubwayGraph: Codable {
    /// 邻接边对应的顶点下标和距离
    struct ArcNode: Hashable, Codable {
        var index: Int
        var distance: Double
    }
    
    private(set) var vertices = [Station]()
    private(set) var arcs = [Int: Set<ArcNode>]()
    
    /// 站点名到它所在下标的 map
    private(set) var stationToIndex = [String: Int]()
    
    /// 起点与终点的坐标对
    struct StationPair: Codable {
        var start: CGPoint
        var destination: CGPoint
    }
    
    /// 所有线路的起始和终点坐标
    private(set) var subwayLines: [StationPair] = []
    
    mutating func addStation(_ station: Station) {
        if stationToIndex.keys.contains(station.name) { return }
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
        
        subwayLines.append(.init(start: startStation.position, destination: destStation.position))
    }
    
    /// 返回许多个点的坐标，代表最短路。参考 Introduction to algorithms
    func minPath(from start: String, to destination: String) -> [StationPair] {
        /// 最短路中每个顶点的前驱点坐标，开始时都是 `nil`
        var previous = [Int?](repeating: nil, count: vertices.count)
        /// 假设一个最大值
        let doubleMax = 1e10
        /// 源点到每个顶点最短路径估计值，实时更新。
        var minDistances = [Double](repeating: doubleMax, count: vertices.count)
        
        guard let startIndex = stationToIndex[start] else { return [] }
        guard let destIndex = stationToIndex[destination] else { return [] }
        minDistances[startIndex] = 0
        
        var verticesToEvaluate: [(index: Int, station: Station)] = []
        for (index, value) in vertices.enumerated() { verticesToEvaluate.append((index, value)) }
        
        while !verticesToEvaluate.isEmpty {
            let newIndex = verticesToEvaluate.removeMin {
                minDistances[$0.index] < minDistances[$1.index] }!.index
            
            guard let nodes = arcs[newIndex] else { continue }
            // 松弛操作
            for arcNode in nodes {
                if minDistances[arcNode.index] > minDistances[newIndex] + arcNode.distance {
                    minDistances[arcNode.index] = minDistances[newIndex] + arcNode.distance
                    previous[arcNode.index] = newIndex
                }
            }
        }
        
        var path = [Int]()
        var index = destIndex
        while index != startIndex {
            path.append(index)
            guard let previous = previous[index] else { return [] }
            index = previous
        }
        path.append(index)
        
        let positions = path.reversed().map { vertices[$0].position }
        var positionPairs: [StationPair] = []
        
        for index in 0..<positions.count-1 {
            positionPairs.append(.init(start: positions[index], destination: positions[index + 1]))
        }
        
        return positionPairs
    }
}

private extension Array {
    /// 根据 `condition` 找到最小的元素删除并返回该元素
    mutating func removeMin(where condition: (Element, Element) -> Bool) -> Element? {
        if isEmpty { return nil }
        var min = (index: 0, value: first!)
        for index in 1..<count {
            let value = self[index]
            if condition(value, min.value) { min = (index, value) }
        }
        remove(at: min.index)
        return min.value
    }
}
