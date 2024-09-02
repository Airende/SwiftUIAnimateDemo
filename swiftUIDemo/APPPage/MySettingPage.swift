//
//  MySettingPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/16.
//

import SwiftUI

struct MySettingPage: View {
    var body: some View {
        NavigationView {
                List{
                    Section {
                        self.VIPInfoCell()
                    }
                    .listRowBackground(Color.black.opacity(0.85))
                    
                    Section {
                        Toggle(isOn: .constant(true), label: {
                            Label("人脸识别", systemImage: "faceid")
                                .font(.callout)
                        })
                        Toggle(isOn: .constant(true)) {
                            Label("应用上锁", systemImage:"key.viewfinder")
                        }
                        
                        Button {
                            
                        } label: {
                            Label("更改密码", systemImage: "ellipsis.viewfinder")
                        }
                    } header: {
                        Text("安全密码")
                    }
                    
                    Section {
                        NavigationLink(destination: Text("")) {
                            Label("更改图标", systemImage: "iphone.circle")
                        }
                        NavigationLink(destination: Text("")) {
                            Label("快捷开启", systemImage: "bolt.circle")
                        }
                        NavigationLink(destination: Text("")) {
                            Label("应用伪装", systemImage: "theatermasks.circle")
                        }
                    } header: {
                        Text("个性化")
                    }
                    
                    Section {
                        NavigationLink(destination: Text("")) {
                            Label("权限管理", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
                        }

                    } header: {
                        Text("其他")
                    }
                    
                    Section {
                        NavigationLink(destination:
                                        Text("")
                        ) {
                            Label("意见反馈", systemImage: "text.bubble")
                        }
                        ShareLink(item: "itms-apps://itunes.apple.com/cn/app/id6499459302?mt=8") {
                            Label("分享给朋友", systemImage: "square.and.arrow.up")
                        }
                        NavigationLink { Text("") } label: {
                            Label("关于我们", systemImage: "person")
                        }
                    } header: {
                        Text("关于我们")
                    }

                }
                .foregroundStyle(Color.black.opacity(0.85))
                .listStyle(.automatic)
                .navigationTitle("设置")
                .scrollIndicators(.hidden)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // 在 iPad 上全屏显示列表
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func VIPInfoCell() -> some View {
        return HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "tennisball.fill")
                        .foregroundStyle(Color.white)
                    Text("开启Pro权限")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                        .fontWeight(.medium)
                }
                .border(Color.black, width: 1)
                .padding(.bottom, 1)
                Text("获取更多个性化设置的权限")
                    .border(Color.black, width: 1)
                    .foregroundStyle(Color.white.opacity(0.6))
            }
            Spacer()
            Button(action: {
                
            }, label: {
                Text("立即开通")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 14))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white)
                    .cornerRadius(10)
            })
            .border(Color.black, width: 1)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
    }
    
    
}

struct SectionBackgroundView: View {
    var color: Color
    var cornerRadius: CGFloat // 圆角大小作为可配置参数
    
    var body: some View {
        GeometryReader { geometry in
            color
                .cornerRadius(cornerRadius) // 应用圆角
                .frame(width: geometry.size.width - 32, height: geometry.size.height)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    MySettingPage()
}
