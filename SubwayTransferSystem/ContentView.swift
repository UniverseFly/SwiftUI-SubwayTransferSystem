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
        for stations in stations {
            for station in stations {
                var station = station
                station.position.x = (station.position.x - 121.38) / 0.2 * 800;
                station.position.y = (31.4 - station.position.y) / 0.2 * 800;
                graph.addStation(station)
            }
        }
        for stations in stations {
            for index in 0..<stations.count-1 {
                graph.addSubwayLine(from: stations[index].name, to: stations[index+1].name)
            }
            for index in (1..<stations.count).reversed() {
                graph.addSubwayLine(from: stations[index].name, to: stations[index-1].name)
            }
        }
        
        return SubwayTransferSystem(graph: graph)
    }()
    
    @State var showOptions = true
    
    var body: some View {
        VStack {
            ZStack {
                SubwayLinesView(model: model)
                MinPathsView(model: model)
                StationsView(model: model)
            }
            .scaleEffect(model.scale)
            .offset(x: model.offset.x, y: model.offset.y)
            
            optionsShowToggle
            if showOptions {
                NavigationView {
                    OperationsForm(model: model).navigationBarTitle("☑️ Options")
                }
                .transition(.move(edge: .bottom))
            }
            
        }.background(background)
    }
    
    /// 整个 app 的背景
    var background: some View {
        Color.white
            .gesture(MagnificationGesture().onChanged{ scale in
                self.model.deltaScale = scale - 1
            }.onEnded { scale in
                self.model.baseScale += (scale - 1)
                self.model.deltaScale = 0
            })
            .highPriorityGesture(DragGesture().onChanged { value in
                self.model.deltaOffset.x = value.location.x - value.startLocation.x
                self.model.deltaOffset.y = value.location.y - value.startLocation.y
            }.onEnded { value in
                self.model.baseOffset.x += value.location.x - value.startLocation.x
                self.model.baseOffset.y += value.location.y - value.startLocation.y
                self.model.deltaOffset = .init(x: 0, y: 0)
            })
    }
    
    /// 控制是否显示 Options 界面的按钮
    var optionsShowToggle: some View {
        HStack {
            Spacer()
            Button(action: {
                withAnimation(.spring()) { self.showOptions.toggle() }
            }) {
                Image(systemName: "chevron.right.circle")
                    .imageScale(.large)
                    .padding()
                    .rotationEffect(.degrees(showOptions ? 90 : 0))
                    .scaleEffect(showOptions ? 1.5 : 1)
            }
        }
    }
}
