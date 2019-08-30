//
//  DataHandler.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/30.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import Foundation
import CoreGraphics

/// Shanghai subway model initialized from external source
///
/// 首先通过 Json 数据导入所有站点，再处理站点返回模型。
let dataModel: SubwayTransferSystem = {
    /// 数组中每个元素代表一条线路的所有站点，顺次相连
    let stationGroups: [[Station]] = load("subwayData.json")
    
    var graph = SubwayGraph()
    for stations in stationGroups {
        for station in stations {
            var station = station
            station.position.x = (station.position.x - 121.38) / 0.2 * 800;
            station.position.y = (31.4 - station.position.y) / 0.2 * 800;
            graph.addStation(station)
        }
    }
    for stations in stationGroups {
        for index in 0..<stations.count-1 {
            graph.addSubwayLine(from: stations[index].name, to: stations[index+1].name)
        }
        for index in (1..<stations.count).reversed() {
            graph.addSubwayLine(from: stations[index].name, to: stations[index-1].name)
        }
    }
    
    return SubwayTransferSystem(graph: graph)
}()

/// Reference:
/// https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
