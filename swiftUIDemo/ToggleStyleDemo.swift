//
//  ToggleStyleDemo.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/9/2.
//

import SwiftUI

struct ToggleStyleDemo: View {
    @State private var isOn: Bool = false
    
    var body: some View {
        VStack {
            Toggle("", isOn: $isOn)
                .frame(width: 80, height: 44)
                .toggleStyle(TimeToggleStyle(themeColor: Color.black))
                .padding()
        }
    }
}

struct TimeToggleStyle: ToggleStyle {
    
    @GestureState private var translation: CGFloat = 0
    @Environment(\.colorScheme) private var colorScheme
    var themeColor: Color = .black
    static let minWidth: CGFloat = 80
    static let minHeight: CGFloat = 32
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Capsule()
//                .fill( configuration.isOn ? Color.orange : Color.red)
                .fill(Color.black.opacity(0.01))
            ZStack {
                GeometryReader(content: { proxy in
                    Color.clear
                    Capsule()
                        .stroke(themeColor.opacity(0.1), lineWidth: 1)
                })
            }
            .mask {
                Capsule()
            }
            
            Rectangle()
                .fill(Color.clear)
                .overlay {
                    GeometryReader { proxy in
                        ZStack {
                            Circle()
                                .fill(themeColor.opacity(0.1))
                                .frame(width: getThumbSize(proxy))
//                                .shadow(color: Color.black.opacity(colorScheme == .dark ? 0.4 : 0.2), radius: proxy.size.height * 0.05)
                                .overlay(
                                    ZStack {
                                        Image(systemName: "clock.arrow.2.circlepath")
                                            .font(.custom("Helvetica Bold", size: proxy.size.height * 0.5))
                                            .foregroundColor(themeColor)
                                            .opacity(configuration.isOn ? 1 : 0)
                                            .scaleEffect(configuration.isOn ? 1 : 0.2)
                                        Image(systemName: "timer")
                                            .font(.custom("Helvetica Bold", size: proxy.size.height * 0.5))
                                            .foregroundColor(themeColor)
                                            .opacity(configuration.isOn ? 0 : 1)
                                            .scaleEffect(configuration.isOn ? 0.2 : 1)
                                    }
                                )
                                .rotation3DEffect(Angle(degrees: configuration.isOn ? 0 : -270), axis: (x: 0, y: 0, z:1))
                        }
                        .offset(x: configuration.isOn ? proxy.frame(in: .local).maxX - (getThumbSize(proxy) * 1.06) : proxy.frame(in: .local).minX + (proxy.size.height - getThumbSize(proxy) * 1.06), y: 1.5)

                    }
                    .highPriorityGesture(
                        DragGesture().updating(self.$translation) { value, state, _ in
                            state = value.translation.width
                        }
                            .onChanged{ value in
                                withAnimation(.customSpring) {
                                    configuration.isOn = value.translation.width > 0
                                }
                            }
                            .onEnded{ value in
                                
                            }
                    )
                    .clipShape(
                        Capsule()
                    )
                }
                .frame(minWidth: TimeToggleStyle.minWidth, minHeight: TimeToggleStyle.minHeight)
        }
        .onTapGesture(count: 1) {
            withAnimation(Animation.customSpring) {
                configuration.isOn.toggle()
            }
        }

    }
    
    private func getThumbSize(_ proxy: GeometryProxy) -> CGFloat {
        proxy.size.height - proxy.size.height * 0.1
    }
}

extension Animation {
    static var customSpring: Animation {
       self.spring(response: 0.28, dampingFraction: 0.8, blendDuration: 0.86)
    }
}

#Preview {
//    ToggleStyleDemo()
    ModeSettingPage()
}
