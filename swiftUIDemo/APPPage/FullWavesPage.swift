//
//  FullWavesPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/28.
//

import SwiftUI

struct FullWavesPage: View {
    let colors = [Color(hex: 0x1D427B), Color(hex: 0x285D99), Color(hex: 0x3476BA), Color(hex: 0x4091DA), Color(hex: 0x54A7E2), Color(hex: 0x71BDEB), Color(hex: 0x91D3F3), Color(hex: 0xB5E8FC)]
    
    @State private var p: CGFloat = 0.002
    @State var waveHeightList: [Double] = [8*Double.random(in: 0.007...0.009),
                                         7*Double.random(in: 0.007...0.009),
                                         6*Double.random(in: 0.007...0.009),
                                         5*Double.random(in: 0.007...0.009),
                                         4*Double.random(in: 0.007...0.009),
                                         3*Double.random(in: 0.007...0.009),
                                         2*Double.random(in: 0.007...0.009),
                                         1*Double.random(in: 0.007...0.009)]
    

    var body: some View {
        GeometryReader { proxy in
            ZStack{
                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
//                    WaveView(waveColor: color, waveHeight: Double(colors.count-index)*Double.random(in: 0.007...0.009), progress: 0)
                    WaveView(waveColor: color, waveHeight: self.waveHeightList[index], progress: 10*p)
                }
                VStack {
                    TimelineView(.periodic(from: .now, by: 1.0 * 1)) { context in
                        Text(context.date, style: .time)
                            .font(.system(size: 120, weight: .medium))
                            .background {
                                LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
                            }
                            .mask({
                                Text(context.date, style: .time)
                                    .font(.system(size: 120, weight: .medium))
                            })
                            .foregroundColor(.clear)
                            .padding(.top, 100)
                            .shadow(color: .clear, radius: 0, x: 0, y: 0)
                    }
                    Spacer()
                }
                  
                VStack {
                    Slider(value: $p, in: 1...5) { _ in
                        
                    }
                }
        
            }
            .shadow(color: Color(hex: 0x1D427B).opacity(0.3), radius: 10, x: 0.0, y: 0.0)
        }
        .background(Color(hex: 0xB5E8FC).opacity(0.5))
        
        .ignoresSafeArea()
    }
}

#Preview {
    FullWavesPage()
}
