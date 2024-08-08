//
//  PageView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/7.
//

import SwiftUI
import ColorfulX

struct PageView: View {
    let items = (1...20).map { "Item \($0)" }
    @State private var offset: CGFloat = 0
    @State var currentPage = 0
    
    
    @State var colors: [Color] = ColorfulPreset.appleIntelligence.colors
    @State var speed: Double = 1
    @State var bias: Double = 0.01
    @State var noise: Double = 0
    @State var transitionSpeed: Double = 5
    
    
    var body: some View {
        
        ColorfulView(color: $colors, speed: $speed, bias: $bias, noise: $noise, transitionSpeed: $transitionSpeed)
        
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                        Text("\(item)--\(proxy.size.width)-\(proxy.size.width)")
//                            .padding(20)
                            .frame(width: proxy.size.width-20, height: 100, alignment: .center)
//                            .padding(20)
                            .foregroundColor(Color.blue)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .padding(20)
                            .background {
                                
                            }
                    }
                }
                .padding(50)
            }
            .onAppear(perform: {
//                UIScrollView.appearance().isPagingEnabled = true
            })
        }

    }
}

#Preview {
    PageView()
}
