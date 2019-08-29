//
//  ContentView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/23.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct ContentView: View {
    @ObservedObject var model: SubwayTransferSystem = {
        var graph = SubwayGraph()
        graph.addStation(Station(name: "上海", position: CGPoint(x: 80, y: 10)))
        graph.addStation(Station(name: "北京", position: CGPoint(x: 50, y: 50)))
        graph.addStation(Station(name: "江苏", position: CGPoint(x: 90, y: 90)))
        graph.addStation(Station(name: "广州", position: CGPoint(x: 10, y: 100)))
        graph.addStation(Station(name: "云南", position: CGPoint(x: 30, y: 200)))
        graph.addStation(Station(name: "广西", position: CGPoint(x: 50, y: 10)))
        graph.addStation(Station(name: "湖南", position: CGPoint(x: 100, y: 200)))
        graph.addSubwayLine(from: "上海", to: "北京")
        graph.addSubwayLine(from: "北京", to: "江苏")
        graph.addSubwayLine(from: "江苏", to: "湖南")
        graph.addSubwayLine(from: "上海", to: "广西")
        graph.addSubwayLine(from: "广西", to: "湖南")
        return SubwayTransferSystem(graph: graph)
    }()
    
    var body: some View {
        VStack {
            ZStack {
                SubwayLinesView(model: model)
                MinPathsView(model: model)
                StationsView(model: model)
            }
            .scaleEffect(model.scale)
            .offset(x: model.offset.x, y: model.offset.y)
            
            NavigationView {
                OperationsForm(model: model).navigationBarTitle("Options")
            }
        }
    }
}
