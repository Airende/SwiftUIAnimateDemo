//
//  TempDomoView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/12.
//

import SwiftUI
import ColorfulX
import AxisSheet

struct TempDomoView: View {
    @State var isOpen = true
    @State var isStart = false
    @State var timeSelectType: Int = 0
    @State var toTimeDate: Date = Date()
    @State var count: Int = 0
    @State private var timeUseType: Int = 1 //1:时长 2:时间点
    @State private var timeLong: CGFloat = 25
    @State private var timeDate: Date = .now + 60*25
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 10) {
                
                Group(content: {
                    Text("📚")
                        .font(.system(size: 150, weight: .regular))
                        .padding(0)
                    HStack {
                        Text(timeUseType==1 ? "专注时长：\(Int(timeLong))分钟" : "专注到：\(Date.formatDateToShanghai(timeDate, dateFormat: "HH:mm"))")
                            .padding(0)
                            .font(.system(size: 20, weight: .medium))
                            .onTapGesture {
                                isOpen.toggle()
                            }
                        Image(systemName: "chevron.forward")
                    }
                    .offset(x: 10)
                })
                
//                HStack {
                    VStack {
                        if isOpen {
                            VStack {
                                HStack(spacing: 20) {
                                    Text("⏳")
                                        .onTapGesture {
                                            self.timeUseType = 1
                                        }
                                        .scaleEffect(0.9)
                                        .opacity(self.timeUseType == 1 ? 1 : 0.3)
                                        
                                    Text("🕒")
                                        .onTapGesture {
                                            self.timeUseType = 2
                                        }
                                        .scaleEffect( 0.9)
                                        .opacity(self.timeUseType == 2 ? 1 : 0.3)
                                }
                                .font(.title)
                                .scaleEffect(0.9)
                                .background(Color.blue.opacity(0.2).padding(-5))
                                .cornerRadius(5.0)
                                
                                ZStack {
                                    SheetTimeLongView(timeLong: $timeLong)
                                        .frame(height: 155)
                                        .rotation3DEffect(
                                            Angle(degrees: self.timeUseType == 1 ? 0 : 90),
                                                                  axis: (x: 1.0, y: 0.0, z: 0.0)
                                        )
                                        .opacity(self.timeUseType == 1 ? 1 : 0)
                                    SheetTimePointView(selectedDate: $timeDate)
                                        .frame(height: 155)
                                        .rotation3DEffect(
                                            Angle(degrees: self.timeUseType == 2 ? 0 : -90),
                                                                  axis: (x: 1.0, y: 0.0, z: 0.0)
                                        )
                                        .opacity(self.timeUseType == 2 ? 1 : 0)
                                }
                            }
                        }else{
                            EmptyView()
                        }
                    }
                    .animation(.easeIn, value: timeUseType)
                    .frame(height: isOpen ? UIScreen.main.bounds.height/4.0 : 0)
                    .animation(.easeInOut, value: isOpen)
                    .padding(.horizontal, 16)
                            
                Button(action: {
                    isStart.toggle()
                    count = 0
                    isOpen = false
                }, label: {
                    Text("开始")
                        .font(.callout)
                        .frame(width: UIScreen.main.bounds.width/2, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                })
                .padding()
            }
            .ignoresSafeArea()
            .animation(.easeInOut, value: isOpen)
            .offset(y: -50)
            
            Waves()
                .ignoresSafeArea()
                .opacity(isStart ? 1 : 0)
                .animation(.linear(duration: 5), value: isStart)
            
            self.logoText()
        }
    }
    
    func formatDateToShanghai(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai") // 设置时区为上海
        formatter.dateFormat = "HH:mm" // 只显示小时和分钟
        return formatter.string(from: date)
    }
    
    func logoText()->some View{
        VStack {
            HStack {
                FlowingColorView(clear: true, colors: ColorfulPreset.lavandula.colors)
                    .frame(width: 300, height: 100)
                    .mask {
                        HStack {
                            Text("竹叶专注")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .padding(20)
                            Spacer()
                        }
                            
                    }
                Spacer()
            }
            Spacer()
        }
        .opacity(0.4)
    }
}

#Preview {
    TempDomoView()
}
