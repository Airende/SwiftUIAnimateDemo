//
//  TimerCircle.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/6.
//

import SwiftUI

struct TimerCircle: View {
    @StateObject var intervalStore = TimeIntervalStore()

    var body: some View {
        ClockView()
            .environmentObject(intervalStore)
            .padding()
            .animation(.default, value: intervalStore.time)
            .onAppear(perform: {
                DispatchQueue.main.async {
                    intervalStore.start()
                }
            })
    }
}

struct ClockView: View {
    @EnvironmentObject var store: TimeIntervalStore
    var body: some View {
        ZStack{
            ClockTickView(sec: store.time)
            ClockHandView(sec: store.time)
        }
    }
}

struct ClockHandView: View {
    var sec: Double
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.clear
                Group {
                    Capsule()
                        .fill(Color.red)
                        .frame(width: 3, height: getHandViewSize(proxy)*0.8)
                        .offset(y: -(getHandViewSize(proxy)/2.17))
                        .rotationEffect(.degrees(sec/60/60*360))
                    Capsule()
                        .fill(Color.green)
                        .frame(width: 3, height: getHandViewSize(proxy)*0.9)
                        .offset(y: -(getHandViewSize(proxy)/2.17))
                        .rotationEffect(.degrees(sec/60*360))
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                    Circle()
                        .frame(width: 5, height: 5)
                        .offset(y: -(getHandViewSize(proxy) + 5))
                        .rotationEffect(.degrees(sec / 60 * 60 * 360))
                }
            }
        }
    }
    
    func getHandViewSize(_ proxy: GeometryProxy) -> CGFloat {
        return proxy.size.width < proxy.size.height ? (proxy.size.width/2-55) : (proxy.size.height/2-55)
    }
}

struct ClockTickView: View {
    var sec: Double
    var tickCount = 60
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                ForEach(0..<tickCount, id: \.self) { tick in
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(tick%5 == 0 ? Color.green : Color.yellow)
                        .frame(width: tick%5 == 0 ? 15 : 2, height: tick%5 == 0 ? 3 : 2)
                        .offset(x: proxy.size.width <= proxy.size.height ? -(proxy.size.width/2-50) : -(proxy.size.height/2-50))
                        .rotationEffect(.degrees(Double(tick)/Double(tickCount))*360)
                        .offset(x: -2.5, y: -2.5)
                }
            }
            .offset(x: proxy.size.width/2, y: proxy.size.height/2)
        }
    }
}



class TimeIntervalStore: ObservableObject {
    
    @Published var isStart: Bool = false
    @Published var time: Double = 0
    @Published var circleTime: Double = 0
    @Published var prevImage: Image = Image(systemName: "network")
    @Published var nextImage: Image = Image(systemName: "globe.asia.australia.fill")
    
    @Published var prevColor: Color = Color(hex: 0x000000)
    @Published var nextColor: Color = Color(hex: 0x5586a2)
    @Published var interval: Double = 0.1
    
    private var currentImageIndex: Int = 0
    private var images = ["globe.asia.australia.fill", "globe.americas", "network"]
    private var colors = [Color(hex: 0x5586A2), Color(hex: 0xF6D256), Color(hex: 0x0C4C89), Color(hex: 0xEF562D), Color(hex: 0x97D5E0)]
    private var timer: Timer?
    
    init(interval: Double = 0.1){
        self.interval = interval
    }
    
    func start(){
        self.timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(run), userInfo: nil, repeats: true)
    }
    
    @objc func run(){
        time += interval
        circleTime += interval
        if Int(circleTime) == 60 {
            circleTime = 0
            DispatchQueue.main.async {
                self.changeImage()
            }
        }
    }
    
    func stop(){
        time = 0
    }
    
    func pause(){
        timer?.invalidate()
    }
    
    func changeImage(){
        prevImage = Image(systemName: images[0])
        nextImage = Image(systemName: images[1])
        
        let imageName = images.remove(at: 0)
        images.append(imageName)
        
        prevColor = colors[0]
        nextColor = colors[1]
        
        let imageColor = colors.remove(at: 0)
        colors.append(imageColor)
    }
    
    deinit {
        timer?.invalidate()
    }
    
}

#Preview {
    TimerCircle()
}
