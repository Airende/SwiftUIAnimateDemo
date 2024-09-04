//
//  Waves.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/5.
//

import SwiftUI

struct Waves: View {
    let colors = [Color(hex: 0x1D427B), Color(hex: 0x285D99), Color(hex: 0x3476BA), Color(hex: 0x4091DA), Color(hex: 0x54A7E2), Color(hex: 0x71BDEB), Color(hex: 0x91D3F3), Color(hex: 0xB5E8FC)]
    var stopAnimation: Bool = true
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack{
                Color.clear
                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                    WaveView(waveColor: color, waveHeight: Double(colors.count-index)*Double.random(in: 0.007...0.009), progress: 0, stopAnimation: stopAnimation)
                }
            }
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
            .overlay {
                
            }
            
        }
        .ignoresSafeArea()
    }
}

struct WaveShape: Shape {
    var offset: Angle
    var waveHeight: Double = 0.025
    var percent: Double
    
    var animatableData: Double {
        get{offset.degrees}
        set{offset = Angle(degrees: newValue)}
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let waveHeight = waveHeight*rect.height
        let yoffset = CGFloat(1.0-percent)*(rect.height-8*waveHeight)
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 361)
        
        p.move(to: CGPoint.init(x: 0, y: yoffset+waveHeight*CGFloat(sin(offset.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 8){
            let x = CGFloat((angle-startAngle.degrees)/360)*rect.width
            p.addLine(to: CGPoint.init(x: x, y: yoffset+waveHeight*CGFloat(sin(Angle(degrees: angle).radians))))
        }
        p.addLine(to: CGPoint.init(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint.init(x: 9, y: rect.height))
        p.closeSubpath()
        return p
    }
}

struct WaveView: View {
    var waveColor: Color
    var waveHeight: Double = 0.025
    var progress: Double
    var stopAnimation: Bool = false
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        ZStack{
            WaveShape(offset: waveOffset, waveHeight: waveHeight, percent: Double(progress)/100)
                .fill(waveColor)
        }
        .onAppear(perform: {
            DispatchQueue.main.async {
                withAnimation(Animation.linear(duration: stopAnimation ? 0 : CGFloat(waveHeight*100)).repeatForever(autoreverses: false)) {
                    self.waveOffset = Angle.degrees(360)
                }
            }
        })
        .scaleEffect(1.05)
    }
}

#Preview {
    Waves()
}
