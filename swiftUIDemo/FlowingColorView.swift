//
//  PageView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/7.
//

import SwiftUI
import ColorfulX

struct FlowingColorView: View {
    let items = (1...20).map { "Item \($0)" }
    @State private var offset: CGFloat = 0
    @State var currentPage = 0
    
    
    @State var colors: [Color] = ColorfulPreset.appleIntelligence.colors
    @State var speed: Double = 1
    @State var bias: Double = 0.01
    @State var noise: Double = 0
    @State var transitionSpeed: Double = 5
    
    
    var body: some View {
        ZStack {
            ColorfulView(color: $colors, speed: $speed, bias: $bias, noise: $noise, transitionSpeed: $transitionSpeed)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                FabulaSlider(value: $speed, title: "速度", min: 0, max: 10).padding(.horizontal, 10)
                FabulaSlider(value: $bias, title: "基准", min: 0.01, max: 1).padding(.horizontal, 10)
                FabulaSlider(value: $noise, title: "噪点", min: 0, max: 100).padding(.horizontal, 10)
                FabulaSlider(value: $transitionSpeed, title: "过度速度", min: 0, max: 30).padding(.horizontal, 10)
            }
        }

    }
}

#Preview {
    FlowingColorView()
}
