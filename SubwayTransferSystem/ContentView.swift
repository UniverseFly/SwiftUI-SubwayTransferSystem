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
    var vertexIDs: [Int] {
        .init(0..<vertices.count)
    }
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
    
    @State var start = ""
    @State var destination = ""
    
    var body: some View {
        VStack {
            ZStack {
                Path { path in
                    for x in model.arcs {
                        path.move(to: model.vertices[x.key].position)
                        for y in x.value {
                            path.addLine(to: model.vertices[y.index].position)
                            path.move(to: model.vertices[x.key].position)
                        }
                    }
                }.strokedPath(StrokeStyle(lineWidth: 5)).fill(Color.red)
                
                ForEach(model.vertexIDs, id: \.self) { index in
                    VertexView()
                        .position(self.model.vertices[index].position)
                }.gesture(DragGesture(minimumDistance: 0.1)
                    .onEnded { value in
                        withAnimation { self.model.addStation(Station(name: "fuck", position: value.location)) }
                    }
                )
            }
            
            TextField("起点", text: $start)
            TextField("终点", text: self.$destination)
            Button(action: {
                withAnimation { self.model.addSubwayLine(from: self.start, to: self.destination) }
            }) { Text("添加线路") }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
