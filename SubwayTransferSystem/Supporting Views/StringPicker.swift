//
//  StringPicker.swift
//  SubwayTransferSystem
//
//  Created by 魏宇翔 on 2019/8/29.
//  Copyright © 2019 Tongji University. All rights reserved.
//

import SwiftUI

/// 一个通用的在许多 `String` 中 pick 的 `View`
struct StringPicker: View {
    var title: String
    var content: [String]
    var selectedIndex: Binding<Int>
    
    var body: some View {
        Picker(title, selection: selectedIndex) {
            ForEach(content.indices, id: \.self) { index in
                Text(self.content[index])
            }
        }
    }
}
