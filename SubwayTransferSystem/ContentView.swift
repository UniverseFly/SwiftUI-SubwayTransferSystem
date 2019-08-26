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
        graph.addSubwayLine(from: "上海", to: "北京")
        graph.addSubwayLine(from: "广州", to: "江苏")
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
        NavigationView {
        VStack {
            ZStack {
                SubwayLinesView(positions: model.subwayLines, show: showSubwayLines)
                
                StationsView.init(stations: model.vertices)
                    .gesture(DragGesture(minimumDistance: 0.1).onEnded { value in
                        self.model.addStation(Station(name: "self.newStationName",
                                                      position: value.location))
                    })
                
                ForEach(points, id: \.0) { point in
                    StretchableLineView(start: point.1, destination: point.2,
                                     show: self.showRecommendedRoutes)
                        .foregroundColor(Color.red)
                }
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
