//
//  TempDomoView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/12.
//

import SwiftUI
import ColorfulX
import AxisSheet

struct TimeModeMainPage: View {
    @Binding var isEditing: Bool
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
                ZStack {
                    Text("📚")
                        .font(.system(size: isEditing ? 200 : 150, weight: .regular))
                        .padding(0)
                        .offset(y: isEditing ? (isOpen ? 150 : 50) : 0)
                    Text("专注模式")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .opacity(isEditing ? 1 : 0)
                        .offset(y:isEditing ? (isOpen ? 280 : 180) : 100)
                }
                .blur(radius: 0)
                    
                Group {
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
                    
                    VStack {
                        HStack(spacing: 20) {
                            Text("⏱️")
                                .onTapGesture {
                                    self.timeUseType = 1
                                }
                                .scaleEffect(0.9)
                                .opacity(self.timeUseType == 1 ? 1 : 0.3)
                                
                            Text("⏰")
                                .onTapGesture {
                                    self.timeUseType = 2
                                }
                                .scaleEffect( 0.84)
                                .opacity(self.timeUseType == 2 ? 1 : 0.3)
                        }
                        .font(.title)
//                                .scaleEffect(0.9)
//                                .background(Color.blue.opacity(0.2).padding(-5))
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
                                .disabled(isOpen ? false : true)
                                .frame(height: 155)
                                .rotation3DEffect(
                                    Angle(degrees: self.timeUseType == 2 ? 0 : -90),
                                                          axis: (x: 1.0, y: 0.0, z: 0.0)
                                )
                                .opacity(self.timeUseType == 2 ? 1 : 0)
                        }
                    }

                    .rotation3DEffect(
                        Angle(degrees: isOpen ? 0 : 90),
                                              axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                    .scaleEffect(isOpen ? 1 : 0.5)
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
                .opacity(isEditing ? 0 : 1)
            }
            .ignoresSafeArea()
            .animation(.easeInOut, value: isOpen)
            .animation(.easeInOut, value: isEditing)
            .offset(y: -50)
            
            Waves()
                .ignoresSafeArea()
                .opacity(isStart ? 1 : 0)
                .animation(.linear(duration: 5), value: isStart)
        }
//        .background(isEditing ? Color.white : Color.clear)
//        .blur(radius: isEditing ? 10 : 0)
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

//#Preview {
//    TimeModeMainPage(isEditing: .constant(false))
//}

#Preview {
    ModeHomeListPage()
}
