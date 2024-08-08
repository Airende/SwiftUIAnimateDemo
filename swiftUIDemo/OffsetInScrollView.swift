//
//  OffsetInScrollView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/7.
//

import SwiftUI

struct OffsetScrollListView: View {
    let gapX: CGFloat = 80
    
    @State private var offset: CGPoint = .zero
    
    init() {
        UIScrollView.appearance().isScrollEnabled = true
    }
    
    var body: some View {
        VStack {
//            Text("scroll Y: \(offset.y)")
            GeometryReader { geoProxy in
                ScrollView {
                    ZStack {
                        LazyVStack {
                            ForEach(0...1000, id: \.self) { index in
                                GeometryReader { proxy in
                                    let y = proxy.frame(in: .named("scroll")).minY
                                    ZStack {
                                        Color.clear
                                        HStack {
                                            Text("[\(index)]_ \(y) _ \(mapYToX(y:y))")
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .font(.callout)
                                                .background(
                                                    Color.blue
                                                )
                                        }
                                        .hueRotation(.degrees(proxy.frame(in: .global).origin.y/10))
//                                        .offset(y: proxy.frame(in: .global).origin.y/10)
//                                        .rotation3DEffect(
//                                            .degrees( proxy.frame(in: .global).origin.y), axis: (x: 0.5, y: 0.0, z: 0.0)
//                                        )
//                                        .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                        .scaleEffect(CGSize(width: 1.0, height: 1.0), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                         
//                                    .offset(x: getCurveValue(y, geoProxy.size.height)*gapX-gapX)
                                }
                                .frame(width: UIScreen.main.bounds.width, height: 100)

                            }
                        }
                        .background(Color.yellow)
                        OffsetInScrollView(named: "scroll")
                    }
                }
            }
//            .ignoresSafeArea()
            .modifier(OffsetOutScrollModifier(offset: $offset, named: "scroll"))
        }
    }
    
    // 函数将 y 映射到 x
    func mapYToX(y: CGFloat) -> CGFloat {
        let minX: CGFloat = 0.7
        let maxX: CGFloat = 1.0
        let yRange: CGFloat = 100
        let normalizedY = y / yRange
        // 使用指数函数进行映射
        let x = maxX - (maxX - minX) * pow(1 - normalizedY, 2)
        return x
    }
    
    func getCurveValue(_ current: Double, _ total: Double) -> CGFloat {
        let x = Double(current) / Double(total)
        let y = (sin(2 * .pi * x - .pi)) / 2.0
        return 1 + 2 * CGFloat(y)
    }
}


struct OffsetInScrollView: View {
    let named: String

    var body: some View {
        GeometryReader { proxy in
            let offset = CGPoint(x: proxy.frame(in: .named(named)).minX, y: proxy.frame(in: .named(named)).minY)
            Color.clear.preference(key: ScrollOffsetKey.self, value: offset)
        }
    }
}


struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        let nextPoint = nextValue()
        value.x = nextPoint.x
        value.y = nextPoint.y
    }
}

struct OffsetOutScrollModifier: ViewModifier {
    @Binding var offset: CGPoint
    let named: String
    
    func body(content: Content) -> some View {
        content
            .coordinateSpace(name: named)
            .onPreferenceChange(ScrollOffsetKey.self, perform: { value in
                offset = value
            })
    }
}


#Preview {
    OffsetScrollListView()
}
