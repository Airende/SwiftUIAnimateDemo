//
//  RollingTextView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/27.
//

import SwiftUI


struct RollingTextDemo: View {
    @State private var count = 123
    var body: some View {
        VStack {
            RollingTextView(value: $count)
            Button("随机") {
                count = Int.random(in: 10...200)
            }
            .padding()
        }
    }
}

struct RollingTextView: View {
    @Binding var value: Int
    var font: Font = .largeTitle
    var weight: Font.Weight = .black
    @State var animationRange: [Int] = []
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<animationRange.count, id: \.self) { index in
                Text("0")
                    .font(font)
                    .fontWeight(weight)
                    .opacity(0)
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            VStack(spacing: 0) {
                                ForEach(0...9, id: \.self) { num in
                                    Text("\(num)")
                                        .font(font)
                                        .fontWeight(weight)
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            }
                            .offset(y: -CGFloat(animationRange[index]) * size.height)
                        }
                        .clipped()
                    }
            }
        }
        .mask(
            LinearGradient(
                gradient: Gradient(colors: [.clear, .white, .white, .white, .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .onAppear {
            animationRange = Array(repeating: 0, count: String(value).count)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                updateText()
            }
        }
        .onChange(of: value) { newValue in
            let extra = "\(newValue)".count - animationRange.count
            if extra > 0 {
                for _ in 0 ..< extra {
                    withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.append(0)
                    }
                }
            } else {
                for _ in 0 ..< -extra {
                    let _ = withAnimation(.easeIn(duration: 0.1)) {
                        animationRange.removeLast()
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                updateText()
            }
        }
    }
    
    func updateText() {
        let stringValue = "\(value)"
        for (index, value) in zip(0..<stringValue.count,stringValue) {
            var fraction = Double(index) * 0.15
            fraction = fraction > 0.5 ? 0.5 : fraction
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 1 + fraction, blendDuration: 1 + fraction )) {
                animationRange[index] = Int(String(value)) ?? 0
            }
        }
    }
}

#Preview {
    RollingTextDemo()
}
