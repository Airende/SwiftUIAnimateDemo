//
//  DemoHomePage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/22.
//

import SwiftUI
import MetalKit
import ColorfulX


struct DemoHomePage: View {
    // 定义列的布局，使用 GridItem 来指定每列的宽度和间距
    let columns = [
        GridItem(.flexible()),  // 每列宽度根据内容自适应
        GridItem(.flexible()),  // 也可以使用 .fixed(100) 来指定固定宽度
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView(content: {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0..<50) { index in
                        Group {
                            if index == 0 {
                                NavigationLink {
                                    FlowingColorView(clear: false)
                                } label: {
                                    ZStack {
                                        FlowingColorView(clear: true)
                                        Text("颜色流动")
                                            .foregroundStyle(Color.white)
                                    }
                                }
                                .frame(height: 100)
                            }else if index == 1 {
                                NavigationLink {
                                    MySKScene(isClear: .constant(false))
                                } label: {
                                    ZStack {
                                        MySKScene(isClear: .constant(true))
                                        Text("重力球")
                                            .foregroundStyle(Color.white)
                                    }
                                }
                            }else if index == 2 {
                                NavigationLink {
                                    CircleTextDemo()
                                } label: {
                                    ZStack {
                                        CircleTextDemo()
                                        Text("旋转文字")
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            }else if index == 3 {
                                NavigationLink {
                                    Drag3D()
                                } label: {
                                    ZStack {
                                        Drag3D()
                                        Text("3D拖拽")
                                            .foregroundStyle(Color.white)
                                    }
                                }
                                .frame(height: 100)
                            }else if index == 4 {
                                NavigationLink {
                                    TimerCircle()
                                } label: {
                                    ZStack {
                                        TimerCircle()
                                        VStack {
                                            Text("时钟")
                                                .foregroundStyle(Color.black)
                                            Spacer()
                                        }
                                    }
                                }
                            }else if index == 5 {
                                NavigationLink {
                                    Waves()
                                } label: {
                                    ZStack {
                                        Waves()
                                        Text("海浪")
                                            .foregroundStyle(Color.yellow)
                                    }
                                }
                            }else if index == 6 {
                                NavigationLink {
                                    ZYAnimateText()
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(height: 100)
                                        Text("文字动画")
                                            .foregroundStyle(Color.white)
                                    }
                                }
                            }else if index == 7 {
                                NavigationLink {
                                    ConfettiView()
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(height: 100)
                                        Text("彩带")
                                            .foregroundStyle(Color.white)
                                    }
                                }
                            } else{
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(height: 100)
                                    .overlay(Text("Item \(index)"))
                            }
                        }
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        })
        .navigationTitle(Text("集合"))
    }
}

#Preview {
    DemoHomePage()
}
