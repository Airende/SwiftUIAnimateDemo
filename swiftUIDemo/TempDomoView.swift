//
//  TempDomoView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/12.
//

import SwiftUI

struct TempDomoView: View {
    @State var isOpen = false
    @State var isStart = false
    @State var timeSelectType: Int = 0
    @State var toTimeDate: Date = Date()
    @State var count: Int = 0
    
    var body: some View {
        
        ZStack{
            VStack {
                
                Text("📚")
                    .font(.system(size: 150, weight: .regular))
                HStack {
                    Text("专注模式 >")
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            isOpen.toggle()
                        }
                }
                
                HStack {
                    VStack {
                        ForEach(0..<2) { index in
                            if isOpen {
                                if index == 0 {
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
                                            
                                            Text("使用专注时间点")
                                                .font(.title2)
                                                .opacity(timeSelectType != index ? 1 : 0)
                                                .animation(.easeInOut, value: timeSelectType)

                                        }
                                    }
                                    .animation(.easeInOut, value: isOpen)
                                    
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
                                }
                            }else {
                                EmptyView()
                            }
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.0))
                .animation(.easeInOut, value: isOpen)
                .frame(height: isOpen ? UIScreen.main.bounds.height/3.0 : 0)
//                .frame(height: UIScreen.main.bounds.height/4.0)
                
                            
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
                FlowingColorView(clear: true)
                    .frame(width: 300, height: 100)
                    .mask {
                        HStack {
                            Text("竹叶专注")
                                .font(.custom(UIFont.familyNames[39], size: 20))
        //                        .font(.title2)
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
