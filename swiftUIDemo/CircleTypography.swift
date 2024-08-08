//
//  CircleTypography.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/6.
//

import SwiftUI

struct CircleTextDemo: View {
    @StateObject private var intervate = TimeIntervalStore()
    @State private var texts: [String] = [
        "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉ",
        "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉ",
        "ㄱㄲㄳㄴㄵㄶㄷㄸㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅃㅄㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ",
        "ㄱㄲㄳㄴㄵㄶㄷㄸㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅃㅄㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ",
        "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋ",
    ]
    var body: some View {
        CircleTypography(texts: $texts)
            .environmentObject(intervate)
            .background(Color.clear)
            .rotation3DEffect(
                .degrees(sin(intervate.time)*100),
                                      axis: (x: 0.0, y: 0.0, z: 1.0)
            )
            .animation(.default, value: intervate.time)
            .onAppear(perform: {
                intervate.start()
            })
    }
}

struct CircleTypography: View {
    @EnvironmentObject var store: TimeIntervalStore
    @Binding var texts: [String]
    
//    private let timer = Timer.publish(every: 0.1, on: .current, in: .default).autoconnect()
    
    var body: some View {
        ZStack {
            ForEach(1..<texts.count, id: \.self) { index in
                getContent(index)
                    .opacity((CGFloat(texts.count)-CGFloat(index-1))*0.2)
            }
        }
    }
    
    private func getContent(_ index: Int) -> some View{
        GeometryReader { proxy in
            if index % 2 == 1 {
                CircleText(isDynamic: true, sec: store.time*Double(index), text: texts[index-1], gap: CGFloat(getFontSize(proxy)*Double(index)))
                    .foregroundColor(.blue)
            }else{
                CircleText(isDynamic: false, sec: store.time * -Double(index), text: texts[index - 1], gap: CGFloat(getFontSize(proxy) * CGFloat(index)))
                    .foregroundColor(Color.red)
            }
        }
    }
    
    private func getFontSize(_ proxy: GeometryProxy) -> CGFloat {
        return min(proxy.size.width, proxy.size.height) / 2 * 0.1
    }
}

struct CircleText: View {
    
    var isDynamic: Bool
    var sec: Double
    var text: String
    var gap: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            ZStack (alignment: .center, content: {
                ForEach(Array(text.enumerated()), id: \.offset) { index, element in
                    ZStack{
                        Text(String(element))
                            .font(.custom("Helvetica Bold", fixedSize: getFontSize(proxy)))
                            .rotation3DEffect(isDynamic ? .degrees(sec)*60 : .degrees(0), axis: (x: 0, y: 0, z: 1))
                    }
                    .offset(y: -(min(proxy.size.width, proxy.size.height) / 2 - gap))
                    .rotationEffect(.degrees(Double(index)/Double(text.count))*360)
                }
            })
            .rotationEffect(.degrees(Double(sec) / Double(text.count)) * 360)
            .offset(x: proxy.size.width / 2 - getFontSize(proxy) / 2, y: proxy.size.height / 2 - getFontSize(proxy) / 2)
        }
    }
    
    private func getFontSize(_ proxy: GeometryProxy) -> CGFloat {
        return min(proxy.size.width, proxy.size.height) / 2 * 0.1
    }
}

#Preview {
    CircleTextDemo()
}
