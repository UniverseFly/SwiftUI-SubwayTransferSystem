//
//  ContentView.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/23.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI
import CoreGraphics

extension SubwayGraph {
    var vertexIDs: Range<Int> { 0..<vertices.count }
}

struct ContentView: View {
    @State var model: SubwayGraph = {
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
        graph.addSubwayLine(from: "上海", to: "湖南")
        graph.addSubwayLine(from: "广西", to: "湖南")
        return graph
    }()
    
    var points: [(Int, CGPoint, CGPoint)] = [
        (0, .init(x: 10, y: 300), .init(x: 200, y: 300)),
        (1, .init(x: 50, y: 300), .init(x: 200, y: 10)),
        (2, .init(x: 100, y: 300), .init(x: 200, y: 250)),
        (3, .init(x: 200, y: 300), .init(x: 200, y: 200)),
    ]
    
    @State private var startIndex = 0
    @State private var destIndex = 0
    @State var showSubwayLines = true
    @State var showRecommendedRoutes = false

    
    var body: some View {
        let minPath = model.minPath(from: "上海", to: "湖南")
        return NavigationView {
        VStack {
            ZStack {
                SubwayLinesView(positions: model.subwayLines, show: showSubwayLines)
                
                ForEach(minPath.indices, id: \.self) { index in
                    StretchableLineView(start: minPath[index].0, destination: minPath[index].1,
                                     show: self.showRecommendedRoutes)
                        .foregroundColor(Color.red)
                }
                
                StationsView.init(stations: model.vertices)
                    .gesture(DragGesture(minimumDistance: 0.1).onEnded { value in
                        self.model.addStation(Station(name: "self.newStationName",
                                                      position: value.location))
                    })
                
            }
            
            Form {
            StationPickerView(stations: model.vertices,
                              start: $startIndex,
                              destination: $destIndex) {
                                let startStation = self.model.vertices[self.startIndex].name
                                let destStation = self.model.vertices[self.destIndex].name
                                self.model.addSubwayLine(from: startStation, to: destStation)
                }
            
            AppUIOptionsView(showSubwayLines: $showSubwayLines,
                             showRecommendedRoutes: $showRecommendedRoutes)
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
