//
//  FullWavesPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/28.
//

import SwiftUI
import AxisSheet
import SlideButton

struct FullWavesPage: View {
    let colors = [Color(hex: 0x1D427B), Color(hex: 0x285D99), Color(hex: 0x3476BA), Color(hex: 0x4091DA), Color(hex: 0x54A7E2), Color(hex: 0x71BDEB), Color(hex: 0x91D3F3), Color(hex: 0xB5E8FC)]

    @StateObject private var timerManager = TimerManager()
    @State private var constants = ASConstant(axisMode: .top, size: 250, background: .init(disabled: false))

    @State var configModel: WavesMainConfigModel = .init()

    @State private var isPresented: Bool = false
    @State var tapView: Bool = false

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
                .ignoresSafeArea()
                  
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
                    Slider(value: $p, in: 1...4.8) { _ in
                        
                    }
                    .offset(y:30)
                }
                
                VStack {
                    HStack {
                            
                        RoundedRectangle(cornerRadius: 0)
                            .fill(LinearGradient(colors: [Color(hex: 0x1D427B),  Color(hex: 0x3476BA).opacity(0.6),Color(hex: 0xB5E8FC).opacity(0)], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 12, height: 2, alignment: .center)
                        Text("20%")
                            .font(.system(size: 10))
                            .foregroundStyle(Color(hex: 0x285D99).opacity(0.8))
                        Spacer()
                        Text("10:10")
                            .font(.system(size: 10))
                            .foregroundStyle(Color(hex: 0x285D99).opacity(0.8))
                        RoundedRectangle(cornerRadius: 0)
                            .fill(LinearGradient(colors: [Color(hex: 0x1D427B),  Color(hex: 0x3476BA).opacity(0.6),Color(hex: 0xB5E8FC).opacity(0)], startPoint: .trailing, endPoint: .leading))
                            .frame(width: 12, height: 2, alignment: .center)
                        
                    }
                }
                
                VStack {
                    Spacer()
                    HoldDownButton(text: "长按解锁", paddingHorizontal: 100, paddingVertical: 20, duration: 2, scale: 0.95, background: .white.opacity(0.5), loadingTint: Color(hex: 0x3476BA), action: {
                        print("1111")
                    })
                    .padding()
                }
                .padding(.bottom, 100)
                .opacity(tapView ? 1 : 0)
                
                
                AxisSheet(isPresented: $isPresented, constants: constants) {
                    SheetWavesConstants(configModel: $configModel)
                }
                .opacity(tapView ? 1 : 0)
        
            }
            .shadow(color: Color(hex: 0x1D427B).opacity(0.3), radius: 10, x: 0.0, y: 0.0)
        }
        .animation(.easeOut, value: tapView)
        .background(Color(hex: 0xB5E8FC).opacity(0.5))
        .onChange(of: isPresented, perform: { newValue in
            if isPresented {
                timerManager.stopTimer()
            }else{
                timerManager.stopTimer()
                timerManager.startTimer {
                    tapView = false
                }
            }
        })
        .onTapGesture {
            tapView.toggle()
            timerManager.stopTimer()
            timerManager.startTimer {
                tapView = false
            }
        }
    }
}

fileprivate
struct SheetWavesConstants: View {
    @Binding var configModel: WavesMainConfigModel
    @State private var currentBrightness = UIScreen.main.brightness
    
    
    init( configModel: Binding<WavesMainConfigModel>) {
        _configModel = configModel
        UITableView.appearance().backgroundColor = .clear
    }
    
    var content: some View {
        Group {
            Section(header: Text("屏幕").foregroundColor(.accentColor)) {
                SheetSlider(title: "亮度", value: $currentBrightness, range: 0...1.0)
                Toggle("常亮", isOn: $configModel.alwaysOn)
                Toggle("显示图片", isOn: $configModel.showIcon)
                Toggle("显示秒钟", isOn: $configModel.showSecond)
            }
            .onChange(of: currentBrightness) { newValue in
                //更改屏幕亮度
                UIScreen.main.brightness = newValue
            }
        }
        .foregroundColor(Color(hex: 0x3476BA))
        .listRowBackground(Color.clear)
    }
    var body: some View {
        ZStack {
            Form {
                content
            }
        }
        .background(
            ZStack {
                Color.gray
                Color.black.opacity(0.75)
            }
        )
    }
}

fileprivate
struct SheetSlider: View {
    let title: String
    @Binding var value: CGFloat
    let range: ClosedRange<CGFloat>
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("\(value, specifier: "%.2f")")
                .font(.caption)
                .opacity(0.5)
            HStack {
                Text(title)
                Slider(value: $value, in: range)
            }
        }
    }
}

struct WavesMainConfigModel {
    var alwaysOn: Bool = false
    var isClearMode: Bool = false
    var showSecond: Bool = true
    var showIcon: Bool = true
}

#Preview {
    FullWavesPage()
}
