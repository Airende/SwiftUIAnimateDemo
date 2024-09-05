//
//  ModeSettingPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/19.
//

import SwiftUI

struct ModeSettingPage: View {
    @State var selectIndex: Int = -1
    @State var isCycleTimeMode: Bool = false
    @State var usePassword: Bool = true
    @State var password: String = "123"
    
    @State var isPresentEdit: Bool = false
    @State private var isTimeOn: Bool = false
    @State private var isDenyInstallOn: Bool = false
    @State private var isDenyDeleteOn: Bool = false
    @State private var isDenyPayOn: Bool = false
    
    @State private var oldPassword: String = "1111"
    
    @State private var isPresent1: Bool = false


    var themeColor: Color = .heiD

    
    var body: some View {
        NavigationStack(root: {
            Form {
                Section {
                    headerInfo()
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color(uiColor: UIColor.systemGroupedBackground))
                
                Section("应用管理") {
                    Group {
                        VStack {
                            HStack {
                                selectAppCell(title: "限制应用", apps: [])
                                Divider()
                                selectAppCell(title: "隐藏应用", apps: [1,2,3])
                            }
                            Divider()
                        }
                        .listRowSeparator(.hidden)
                        ToggleSwitch(image: "plus.square.fill", title: "限制安装", isOn: $isDenyInstallOn, themeColor: themeColor)
                        ToggleSwitch(image: "minus.square.fill", title: "限制删除", isOn: $isDenyDeleteOn, themeColor: themeColor)
                        ToggleSwitch(image: "yensign.square.fill", title: "限制支付", isOn: $isDenyPayOn, themeColor: themeColor)
                    }
                    .foregroundStyle(Color.heiD)
                    .font(.system(size: 16))
                }
                
                Section("密码") {
                    toggleSwitch(title:"使用密码", isOn: $usePassword)
                    if usePassword {
                        NavigationLink {
                            if oldPassword.count > 0 {
                                ResetPasswordPage(isChangePassword: true)
                            } else {
                                ResetPasswordPage()
                            }
                        } label: {
                            if usePassword {
                                Text(oldPassword.count > 0 ? "修改密码" : "密码设置")
                            }
                        }
                    }
                }
                
                
                
                Section("时间设置") {
                    VStack() {
                        HStack(alignment: .top) {
                            Text("时长模式")
                                .foregroundStyle( !isCycleTimeMode ? Color.green : Color.secondary)
                                .fontWeight(!isCycleTimeMode ? .medium : .regular)
                                .onTapGesture {
                                    isCycleTimeMode = false
                                    //使动画和下方的布局不在同一个周期
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.02, execute: DispatchWorkItem(block: {
                                        withAnimation(Animation.customSpring) {
                                            isTimeOn = false
                                        }
                                    }))
                                }
                            
                            Toggle("", isOn: $isTimeOn)
                                .frame(width: 160, height: 20)
                                .toggleStyle(TimeToggleStyle(themeColor: Color.green))
                                .frame(maxWidth: .infinity)
                                .onChange(of: isTimeOn) { newValue in
                                    isCycleTimeMode = isTimeOn
                                }
                            Text("周期模式")
                                .foregroundStyle( isCycleTimeMode ? Color.green : Color.secondary)
                                .fontWeight(isCycleTimeMode ? .medium : .regular)
                                .onTapGesture {
                                    isCycleTimeMode = true
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.02, execute: DispatchWorkItem(block: {
                                        withAnimation(Animation.customSpring) {
                                            isTimeOn = true
                                        }
                                    }))
                                }
                        }
                        .padding(.vertical, 5)
                        .font(.system(size: 19))
                        
                        if isCycleTimeMode {
                            VStack {
                                Divider()
                                HStack {
                                    Label("时长", systemImage:"gauge.with.needle.fill")
                                        .foregroundStyle(Color.black.opacity(0.85))
                                    Spacer()
                                    Text("开启后每天")
                                        .foregroundStyle(Color.secondary)
                                        .font(.system(size: 14))
                                    
                                }
                                Divider()
                            }
                            
//                            addTimeCycleCell(timeCycle: "00:00-00:00", weekly: "", isOpen: true)
//                                .onTapGesture {
//                                    isPresent1.toggle()
//                                }
//                                .sheet(isPresented: $isPresent1) {
//                                    AddCycleTimePage(isOpen: $isTimeOn)
//                                }
//                            addTimeCycleCell(timeCycle: "9:00-10:00", weekly: "", isOpen: true)
//                            addTimeCycleCell(timeCycle: "19:00-21:00", weekly: "", isOpen: false)

                            Button("添加定时(后续开放)") {
                                
                            }
                            .buttonStyle(.plain)
                            .padding(5)
                            .foregroundStyle(Color.green)
                        }else{
                            VStack {
                                Divider()
                                HStack {
                                    Label("时长", systemImage:"timer.circle.fill")
                                    Spacer()
                                    Text("稍后主页面设置")
                                        .foregroundStyle(Color.secondary)
                                        .font(.system(size: 14))
                                    
                                }
                                Divider()
                                HStack {
                                    Label("启用动画", systemImage:"fireworks")
                                    Spacer()
                                }
                                
                                HStack {
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .fill(Color.black.opacity(0.9))
                                        .frame(height: 100)
                                        .onTapGesture {
                                            if selectIndex == 0 {
                                                selectIndex = -1
                                            }else{
                                                selectIndex = 0
                                            }
                                        }
                                        .overlay(
                                            //圆角
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(selectIndex == 0 ? Color.green.opacity(1) : Color.green.opacity(0.1), lineWidth: selectIndex == 0 ? 3 : 0)
                                        )
                                        .overlay {
                                            Text("9:41")
                                                .font(.system(size: 30))
                                                .fontWeight(.medium)
                                                .foregroundStyle(Color.white.opacity(0.75))
                                        }
                                        
                                    Waves(stopAnimation: selectIndex == 1 ? false : true)
                                        .frame(height: 100)
                                        .onTapGesture {
                                            if selectIndex == 1 {
                                                selectIndex = -1
                                            }else{
                                                selectIndex = 1
                                            }
                                        }
                                        .background(content: {
                                            Color(hex: 0xB5E8FC).opacity(0.4)
                                        })
                                        .mask {
                                            RoundedRectangle(cornerRadius: 10.0)
                                        }
                                        .overlay(
                                            //圆角
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(selectIndex == 1 ? Color.green.opacity(1) : Color.green.opacity(0.1), lineWidth: selectIndex == 1 ? 3 : 0)
                                        )
                                        
                                }
                            }
                        }
                    }
                }
                
                Section {
                    Button("删除该模式") {
                        
                    }
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity)
                }
            }
            .foregroundColor(themeColor)
            .animation(.easeInOut, value: usePassword)
            .sheet(isPresented: $isPresentEdit) {
                AddModeNamePage()
            }
            .navigationTitle("模式设置")
            .navigationBarTitleDisplayMode(.inline)
         
        })
    }
    
    func headerInfo() -> some View {
        return HStack {
            Spacer()
            Button(action: {
                self.isPresentEdit.toggle()
            }, label: {
                VStack {
                    Text("⛈️")
                        .font(.system(size: 120))
                    Text("市值风云")
                        .font(.system(size: 28))
                        .fontWeight(.medium)
                        .foregroundStyle(themeColor)
                }
            })

            Spacer()
        }
    }
    
    //开关列表
    func toggleSwitch(title: String, image: String? = nil, isOn: Binding<Bool>) -> some View{
        return HStack {
            if image != nil {
                Label(title, systemImage:image ?? "")
            }else {
                Text(title)
            }
            Spacer()
            ZYToggle(isOn: isOn, onColor: themeColor)
                .frame(width: 48, height: 28)
        }
    }
    
    func selectAppCell(title: String, apps: [Int]) -> some View {
        return VStack {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(.caption)
            }
            
            if apps.count < 1 {
                Text("暂无选择")
                    .foregroundStyle(themeColor.opacity(0.2))
                    .font(.title2)
                    .frame(height: 45)
            }else{
                HStack {
                    ForEach(Array(apps.enumerated()), id: \.offset) { model, index in
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.green)
                            .frame(width: 45, height: 45)
                    }
                }
            }
        }
    }
    
    func addTimeCycleCell(timeCycle: String, weekly: String, isOpen: Bool) -> some View{
        return VStack {
            HStack {
                Image(systemName: "clock.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.primary)
                VStack(alignment: .leading) {
                    Text(timeCycle)
                    Text("每周一，周三，周日")
                }
                .foregroundStyle(Color.primary)
                Spacer()
                Text(isOpen ? "打开" : "关闭")
                Image(systemName: "chevron.forward")
                    .font(.callout)
            }
            .foregroundStyle(Color.gray)
            Divider()
        }
    }
}

#Preview {
    ModeSettingPage()
}
