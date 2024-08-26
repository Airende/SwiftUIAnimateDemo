//
//  FullTimePage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/26.
//

import SwiftUI
import AxisSheet
import SlideButton

struct FullTimePage: View {
    @StateObject private var timerManager = TimerManager()

    @State private var isPresented: Bool = false
    @State private var constants = ASConstant(axisMode: .top, size: 250, background: .init(disabled: false))
    @State private var alwaysOn = false
    
    @State var configModel: TimeMainConfigModel = .init()
    @State var tapView: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TimelineView(.periodic(from: .now, by: 1.0 * 1)) { context in
                VStack(spacing: 20) {
                    HStack {
                        Text(self.subTimeString(timeDate: context.date, start: 0, end: 6))
                        Text(self.getTodayWeekday())
                    }
                    .padding(.bottom, 20)
                    .font(.custom("Monaco", size: 20))

                    Group {
                        VStack {
                            //时间
                            HStack(alignment:.bottom) {
                                //时分
                                Text(self.subTimeString(timeDate: context.date, start: 7, end: 12))
                                //秒
                                Text(self.subTimeString(timeDate: context.date, start: 13, end: 15))
                                    .font(.system(size: 20))
                                    .offset(x: -8, y: -25)
                                    .frame(width: 30)
                                    .padding(.trailing, 10)
                                    .opacity(configModel.showSecond ? 1 : 0)
                            }
                            .animation(.easeInOut, value: configModel.showSecond)
                            
                            HStack(alignment: .bottom) {
                                if configModel.showProgress {
                                    Text("⏳")
                                    Text("30%")
                                }
                                Spacer()
                                Text("🎯")
                                    .offset(x:-10 ,y: -1.5)
                                Text("10:30")
                                    .offset(x:-15)
                            }
                            .animation(.easeInOut, value: configModel.showProgress)
                            .font(.custom("Monaco", size: 20))
                            .padding(.horizontal, 10)
                        }
                    }
                    .offset(x:21, y:-50)
                }
                .fontWidth(.standard)
                .font(.custom("Monaco", size: 130))
                .foregroundStyle(Color.white.opacity(0.5))
            }
            
            HStack{
                Divider()
            }
            VStack {
                Divider()
            }
            
            VStack {
                Spacer()
                SlideButton(styling: .init()) {
    //                print("jjjjjjjjj")
                } label: {
                    Text("解锁文本")
                }
                .padding()
            }
            .padding(.bottom, 100)
            .opacity(tapView ? 1 : 0)
            
            
            AxisSheet(isPresented: $isPresented, constants: constants) {
                SheetConstants(constants: $constants, configModel: $configModel)
            }
            .opacity(tapView ? 1 : 0)
        }
        .animation(.easeIn(duration: 0.75), value: tapView)
        .onAppear(perform: {
            // 当视图出现时，设置屏幕常亮
            UIApplication.shared.isIdleTimerDisabled = alwaysOn
        })
        .onDisappear(perform: {
            UIApplication.shared.isIdleTimerDisabled = false
        })
        .onTapGesture {
            tapView.toggle()
            timerManager.stopTimer()
            timerManager.startTimer {
                tapView = false
            }
        }
        .statusBar(hidden: true)
    }
    
    func formatDateToShanghai(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai") // 设置时区为上海
        formatter.dateFormat = "MM月dd日 HH:mm:ss" // 只显示小时和分钟
        return formatter.string(from: date)
    }
    
    func subTimeString(timeDate: Date, start: Int, end: Int)->String{
        let str = self.formatDateToShanghai(timeDate)
        // 获取从索引 7 开始，到索引 12 结束的子字符串
        let startIndex = str.index(str.startIndex, offsetBy: start)
        let endIndex = str.index(str.startIndex, offsetBy: end)

        // 使用 range 获取子字符串
        let range = startIndex..<endIndex
        let substring = String(str[range])
        return substring
    }
    
    func getTodayWeekday() -> String{
        // 获取当前日期
        let today = Date()
        // 使用当前日历
        let calendar = Calendar.current

        // 获取当前日期对应的星期几
        let weekday = calendar.component(.weekday, from: today)

        // 输出为整数（1 代表周日，2 代表周一，以此类推）
        print("今天是星期 \(weekday)")

        // 可选：将整数转换为星期几的字符串表示
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN") // 设置为中文
        dateFormatter.dateFormat = "EEEE"
        let weekdayString = dateFormatter.string(from: today)
        return weekdayString
    }
}

class TimerManager: ObservableObject {
    @Published var timeCount = 0.0
    var timer: Timer?

    func startTimer(count: CGFloat = 10.0, completed: @escaping()->()) {
        // 启动定时器，每秒更新一次
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.timeCount += 1
            if self?.timeCount ?? 0 == count {
                completed()
                self?.stopTimer()
            }
        }
    }

    func stopTimer() {
        // 取消定时器
        self.timeCount = 0.0
        timer?.invalidate()
        timer = nil
    }
}

fileprivate
struct SheetConstants: View {
    @Binding var constants: ASConstant
    @Binding var configModel: TimeMainConfigModel
    @State private var currentBrightness = UIScreen.main.brightness
    
    
    init(constants: Binding<ASConstant>, configModel: Binding<TimeMainConfigModel>) {
        _constants = constants
        _configModel = configModel
        UITableView.appearance().backgroundColor = .clear
    }
    
    var content: some View {
        Group {
            Section(header: Text("屏幕").foregroundColor(.accentColor)) {
                SheetSlider(title: "亮度", value: $currentBrightness, range: 0...1.0)
                Toggle("常亮", isOn: $configModel.alwaysOn)
                Toggle("显示进度", isOn: $configModel.showProgress)
                Toggle("显示秒钟", isOn: $configModel.showSecond)
//                SheetSlider(title: "size", value: $constants.header.size, range: 24...70)
//                SheetSlider(title: "shortAxis", value: $constants.header.shortAxis, range: 0...10)
//                SheetSlider(title: "longAxis", value: $constants.header.longAxis, range: 0...80)
//                SheetSlider(title: "radius", value: $constants.header.cornerRadius, range: 0...(constants.header.size / 2))
//                ColorPicker("foregroundColor", selection: $constants.header.color)
//                ColorPicker("backgroundColor", selection: $constants.header.backgroundColor)
            }
            .onChange(of: currentBrightness) { newValue in
                //更改屏幕亮度
                UIScreen.main.brightness = newValue
            }
        }
        .foregroundColor(Color.white)
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

struct TimeMainConfigModel {
    var alwaysOn: Bool = false
    var showProgress: Bool = true
    var showSecond: Bool = true
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

#Preview {
    FullTimePage()
}
