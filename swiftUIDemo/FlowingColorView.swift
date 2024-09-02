//
//  PageView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/7.
//

import SwiftUI
import ColorfulX

enum ColorfulExtentsion {
    case blackBlue
    
    public var colors: [Color] {
        switch self {
        case .blackBlue: [make(0, 0, 0), make(108, 137, 198), make(44, 59, 108), make(22, 30, 45)]
        }
    }
}

struct FlowingColorView: View {    
    var clear = true
    
    @State private var offset: CGFloat = 0
    @State var currentPage = 0
    
    @AppStorage("preset") var preset: ColorfulPreset = ColorfulPreset.starry

    @State var colors: [Color] = ColorfulPreset.starry.colors

//    @State var colors: [Color] = [.black,.black.opacity(0.9),.black.opacity(0.5),.black.opacity(0.8)]
    @State var speed: Double = 0.3
    @State var bias: Double = 0.01
    @State var noise: Double = 0
    @State var renderScale: Double = 2
    @State var transitionSpeed: Double = 5
    
    var body: some View {
        ZStack {
            ColorfulView(color: $colors, speed: $speed, bias: $bias, noise: $noise, transitionSpeed: $transitionSpeed, renderScale: $renderScale)
                .ignoresSafeArea()
            if !clear {
                VStack {
                    Spacer()
                    presetPicker
                    FabulaSlider(value: $speed, title: "速度", min: 0, max: 10).padding(.horizontal, 10)
                    FabulaSlider(value: $bias, title: "基准", min: 0.01, max: 1).padding(.horizontal, 10)
                    FabulaSlider(value: $noise, title: "噪点", min: 0, max: 100).padding(.horizontal, 10)
                    FabulaSlider(value: $transitionSpeed, title: "过度速度", min: 0, max: 30).padding(.horizontal, 10)
                }
            }
        }
    }
    
    var presetPicker: some View {
        HStack {
          
            Text("主题")
            Picker("", selection: $preset) {
                ForEach(ColorfulPreset.allCases, id: \.self) { preset in
                    Text(preset.hint).tag(preset)
                }
            }
            .foregroundStyle(Color.white)
            .frame(width: 138)
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(preset.colors, id: \.self) { color in
                        Text("8")
                            .opacity(0)
                            .overlay(Circle().foregroundColor(color))
                    }
                }
            }
            .flipsForRightToLeftLayoutDirection(true)
            .environment(\.layoutDirection, .rightToLeft)
        }
        .onChange(of: preset) { colors = $0.colors}
        .padding(10)
    }
}

private func make(_ r: Int, _ g: Int, _ b: Int, _ a: Int = 255) -> Color {
    Color(ColorElement(
        red: Double(r) / 255,
        green: Double(g) / 255,
        blue: Double(b) / 255,
        alpha: Double(a) / 255
    ))
}

#Preview {
    FlowingColorView()
}
