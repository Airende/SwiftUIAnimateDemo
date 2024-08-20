//
//  TempDomoView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/12.
//

import SwiftUI
import ColorfulX

struct TempDomoView: View {
    @State var isOpen = false
    @State var isStart = false
    @State var timeSelectType: Int = 0
    @State var toTimeDate: Date = Date()
    @State var count: Int = 0
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 10) {
                
                Group(content: {
                    Text("📚")
                        .font(.system(size: 150, weight: .regular))
                        .padding(0)
                    HStack {
                        Text("专注模式")
                            .padding(0)
                            .font(.system(size: 20, weight: .bold))
                            .onTapGesture {
                                isOpen.toggle()
                            }
                        Image(systemName: "chevron.forward")
                    }
                    .offset(x: 10)
                })
                
//                HStack {
                    VStack {
                        ForEach(0..<2) { index in
                            if isOpen {
                                if index == 0 {
                                    ZStack {
                                        DatePicker(selection: $toTimeDate, in: Date()...Date()+60*2, displayedComponents: .hourAndMinute) {
                                        }
                                        .labelsHidden()
                                        .frame(maxWidth: .infinity)
                                        .scaleEffect(.init(1.5))
                                        .opacity(timeSelectType == index ? 1 : 0)
                                        .frame(maxHeight: timeSelectType == index ? 100 : 50)
                                        .background(
//                                            timeSelectType == index ? Color.blue.opacity(0.15) : Color.gray.opacity(0.2)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.clear, lineWidth: 2)
//                                                .shadow(color: Color.red.opacity(1), radius: 20, x: 2, y: 2)
                                        )
                                        .cornerRadius(20)
                                        .onTapGesture {
                                            timeSelectType = index
                                        }
                                        .shadow(color: Color.blue.opacity(0.2), radius: 5, x: 0, y: 2)
                                        
                                        Text("使用专注时间点")
                                            .font(.title2)
                                            .opacity(timeSelectType != index ? 1 : 0)
                                    }
                                    .animation(.easeInOut, value: timeSelectType)
                                    
                                }else{
                                    ZStack {
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                            .foregroundColor(
                                                timeSelectType == index ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2)
                                            )
                                            .frame(maxHeight: timeSelectType == index ? 100 : 50)
                                            .onTapGesture {
                                                timeSelectType = index
                                            }
                                            .animation(.easeInOut, value: timeSelectType)
                                        ZStack {
                                            DatePicker(selection: $toTimeDate, in: Date()...Date()+60*2, displayedComponents: .hourAndMinute) {
                                            }
                                            .frame(width: 0, alignment: .center)
                                            .scaleEffect(.init(1.5))
                                            .opacity(timeSelectType == index ? 1 : 0)
                                            .animation(.easeInOut, value: timeSelectType)
                                            
                                            Text("使用时长专注")
                                                .font(.title2)
                                                .opacity(timeSelectType != index ? 1 : 0)
                                                .animation(.easeInOut, value: timeSelectType)
                                        }
                                    }
                                    .animation(.easeInOut, value: timeSelectType)
                                }
                                
                            }else {
                                EmptyView()
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(height: isOpen ? UIScreen.main.bounds.height/4.0 : 0)
                    .animation(.easeInOut, value: isOpen)
                    .background (
//                        Color.gray.opacity(0.05)
//                            .cornerRadius(20)
                    )
                    .padding(.horizontal, 16)
                            
                Button(action: {
                    isStart.toggle()
                    count = 0
                    isOpen = false
                }, label: {
                    Text("开始")
                        .font(.callout)
                        .frame(width: UIScreen.main.bounds.width/2.5, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                })
            }
            .ignoresSafeArea()
            .animation(.easeInOut, value: isOpen)
            .offset(y: -50)
            
            Waves()
                .ignoresSafeArea()
                .opacity(isStart ? 1 : 0)
                .animation(.linear(duration: 5), value: isStart)
            
            self.logoText()
            
//            TimelineView(.periodic(from: .now, by: 1.0 * 1)) { context in
//                VStack {
//                    Text(String(describing: self.formatDateToShanghai(context.date)))
//                        .font(.largeTitle)
//                }
//            }

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
