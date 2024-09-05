//
//  MySettingPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/16.
//

import SwiftUI

struct MySettingPage: View {
    @State private var faceIdOpen: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                    Section {
                        self.VIPInfoCell()
                    }
                    
                    Section {
                        ToggleSwitch(image: "faceid", title: "人脸识别", isOn: $faceIdOpen)
                        ToggleSwitch(image: "key.viewfinder", title: "应用上锁", isOn: $faceIdOpen)
                        
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
                .listStyle(.automatic)
                .navigationTitle("设置")
                .scrollIndicators(.hidden)
                .navigationBarTitleDisplayMode(.inline)

        }
        .foregroundStyle(Color.heiD)
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
                .padding(.bottom, 1)
                Text("获取更多个性化设置的权限")
                    .foregroundStyle(Color.white.opacity(0.6))
            }
            
            Spacer()
            
            NavigationLink {
                BuyVIPPage()
            } label: {
                HStack {
                    Spacer()
                    Text("立即开通")
                        .foregroundStyle(Color.black)
                        .font(.system(size: 14))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .cornerRadius(5)
                }
            }
            .frame(width: 110)
            .padding(.trailing, -20)
        }
        .padding(.vertical, 10)
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
