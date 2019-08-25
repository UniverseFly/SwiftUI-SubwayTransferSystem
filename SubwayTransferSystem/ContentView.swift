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
    
    var subwayLineIDs: [Int] {
        .init(0..<subwayLines.count)
    }
}

struct StationsView: View {
    @Binding var model: SubwayGraph
    
    var body: some View {
        ForEach(model.vertexIDs, id: \.self) { index in
            VertexView(name: self.model.vertices[index].name)
                .position(self.model.vertices[index].position)
        }.gesture(DragGesture(minimumDistance: 0.1)
            .onEnded { value in
                withAnimation { self.model.addStation(Station(name: "fuck", position: value.location)) }
            }
        )
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
    
    var points: [(Int, CGPoint, CGPoint)] = [
        (0, .init(x: 10, y: 300), .init(x: 200, y: 300)),
        (1, .init(x: 50, y: 300), .init(x: 200, y: 10)),
        (2, .init(x: 100, y: 300), .init(x: 200, y: 250)),
        (3, .init(x: 200, y: 300), .init(x: 200, y: 200)),
    ]
    
    @State var tog = false
    
    var body: some View {
        VStack {
            ZStack {
                SubwayLinesView(model: $model)
                StationsView(model: $model)
                if (tog) {
                    ForEach(points, id: \.0) { point in
                        LineView(start: point.1, end: point.2)
                            .foregroundColor(Color.red)
                    }
                }
            }
            Toggle(isOn: $tog) { Text("nothing") }.frame(width: 40, height: 20)
        }
    }
}

struct SubwayLinesView: View {
    @Binding var model: SubwayGraph
    @State var start = 0
    @State var destination = 0
    @State private var ratio: CGFloat = 0
    
    var body: some View {
        VStack {
            SubwayLines(model: model)
            Picker(selection: $start, label: Text("起点")) {
                ForEach(model.vertexIDs, id: \.self) { index in
                    Text(self.model.vertices[index].name)
                }
            }
            Picker(selection: $destination, label: Text("终点")) {
                ForEach(model.vertexIDs, id: \.self) { index in
                    Text(self.model.vertices[index].name)
                }
            }
            Button(action: {
                self.model.addSubwayLine(from: self.model.vertices[self.start].name, to: self.model.vertices[self.destination].name)
                }
            ) { Text("添加线路") }
        }
    }
}

struct SubwayLines: View {
    var model: SubwayGraph
    
    var body: some View {
        ZStack {
            ForEach(model.subwayLineIDs, id: \.self) { id in
                LineView(start: self.model.subwayLines[id].start,
                         end: self.model.subwayLines[id].destination)
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

struct LineView: View {
    @State private var show: Bool = false
    var start: CGPoint
    var end: CGPoint
    
    var body: some View {
        Line(ratio: show ? 1 : 0, start: start, end: end)
            .stroke(lineWidth: 3.3)
            .animation(.easeInOut(duration: 1.5))
            .onAppear { self.show = true }
    }
}

struct Line: Shape {
    var ratio: CGFloat
    var start: CGPoint
    var end: CGPoint

    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: start)
        p.addLine(to: CGPoint(x: start.x + ratio * (end.x - start.x),
                              y: start.y + ratio * (end.y - start.y)))

        return p
    }

    var animatableData: CGFloat {
        get { return ratio }
        set { ratio = newValue }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
