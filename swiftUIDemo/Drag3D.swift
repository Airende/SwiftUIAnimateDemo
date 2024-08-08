//
//  Drag3D.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/6.
//

import SwiftUI

struct Drag3D: View {
    var body: some View {
        FlaredRounded {
            Text("拖拽")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(50)
        }
        .padding(50)
        .modifier(Drag3DModifier())
    }
}

struct FlaredRounded<Content>: View where Content :View {
    var backgroundColor: Color = Color(hex: 0x232834).opacity(0.8)
    var intensity: CGFloat = 0.5
    var cornerRadius: CGFloat = 12
    var gradient: Gradient = .init(colors: [.white, .init(hex: 0xa85f89), .init(hex: 0xa85f89).opacity(0)])
    
    @ViewBuilder var content: ()->Content
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .overlay {
                    GeometryReader { proxy in
                        ZStack(alignment: .topLeading) {
                            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .mask {
                                    RoundedCorners(tl: cornerRadius, insetAmount: 0)
                                }
                                .opacity(0.12)
                            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .mask {
                                    RoundedCorners(tl: cornerRadius)
                                        .strokeBorder(lineWidth: 3)
                                }
                                .opacity(1)
                        }
                        .frame(width: getSquareSize(proxy).width, height: getSquareSize(proxy).height)
                        .mask {
                            LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0), .black.opacity(0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        }
                    }
                    .opacity(intensity)
                }
            content()
        }
    }
    private func getSquareSize(_ proxy: GeometryProxy) -> CGSize {
        var size = proxy.size
        var min = min(size.width, size.height) - cornerRadius
        if min < 0 { min = 0 }
        size = CGSize(width: min, height: min)
        return size
    }
    
}

struct RoundedCorners: InsettableShape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height
        
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0 + insetAmount, y: insetAmount))
        path.addLine(to: CGPoint(x: w - tr + insetAmount, y: insetAmount))
        path.addArc(center: CGPoint(x: w - tr + insetAmount, y: tr + insetAmount), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: w + insetAmount, y: h - br + insetAmount))
        path.addArc(center: CGPoint(x: w - br + insetAmount, y: h - br + insetAmount), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: bl + insetAmount, y: h + insetAmount))
        path.addArc(center: CGPoint(x: bl + insetAmount, y: h - bl + insetAmount), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: insetAmount, y: tl + insetAmount))
        path.addArc(center: CGPoint(x: tl + insetAmount, y: tl + insetAmount), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        path.closeSubpath()
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var rectangle = self
        rectangle.insetAmount += amount
        return rectangle
    }
}

struct Drag3DModifier: ViewModifier {
    @State var dragAmount = CGSize.zero
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.easeIn(duration: 0.12)){
                    dragAmount = value.translation
                }
            }
            .onEnded { _ in
                withAnimation(.spring()){
                    dragAmount = .zero
                }
            }
    }
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(-Double(dragAmount.width)/8),
                                      axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .rotation3DEffect(
                .degrees(Double(dragAmount.height/8)),
                                      axis: (x: 1.0, y: 0.0, z: 0.0)
            )
            .offset(dragAmount)
            .gesture(drag)
    }
}

#Preview {
    Drag3D()
}
