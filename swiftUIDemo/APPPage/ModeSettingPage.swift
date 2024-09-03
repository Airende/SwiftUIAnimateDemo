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


    var themeColor: Color = .green

    
    var body: some View {
        NavigationView(content: {
            List {
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
                        toggleSwitch(title: "限制安装", image: "plus.square.fill", isOn: $isDenyInstallOn)
                        toggleSwitch(title: "限制删除", image: "minus.square.fill", isOn: $isDenyDeleteOn)
                        toggleSwitch(title: "限制支付", image: "yensign.square.fill", isOn: $isDenyPayOn)
                    }
                    .foregroundStyle(Color.black.opacity(0.85))
                    .font(.system(size: 16))
                }
                
                
                Section("密码") {
                    toggleSwitch(title:"使用密码", isOn: $usePassword)
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
                
                Section("时间设置") {
                    VStack() {
                        HStack(alignment: .top) {
                            Text("时长模式")
                                .foregroundStyle( !isCycleTimeMode ? Color.green : Color.secondary)
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
                                .onTapGesture {
                                    isCycleTimeMode = true
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.02, execute: DispatchWorkItem(block: {
                                        withAnimation(Animation.customSpring) {
                                            isTimeOn = true
                                        }
                                    }))
                                }
                        }
                        
                        if isCycleTimeMode {
                            addTimeCycleCell(timeCycle: "00:00-00:00", weekly: "", isOpen: true)
                            addTimeCycleCell(timeCycle: "9:00-10:00", weekly: "", isOpen: true)
                            addTimeCycleCell(timeCycle: "19:00-21:00", weekly: "", isOpen: false)
                                .onTapGesture {
                                    
                                }
                            Button("添加定时") {
                                
                            }
                            .buttonStyle(.plain)
                            .padding(5)
                            .foregroundStyle(Color.green)
                        }else{
                            Text("添加成功后可在主页面设置")
                                .font(.title3)
                                .foregroundStyle(Color.green.opacity(0.9))
                                .padding()
                        }
                    }
                }
                
                Section("动画设置") {
                    HStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.green.opacity(0.3))
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
                            
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.green.opacity(0.3))
                            .frame(height: 100)
                            .onTapGesture {
                                if selectIndex == 1 {
                                    selectIndex = -1
                                }else{
                                    selectIndex = 1
                                }
                            }
                            .overlay(
                                //圆角
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectIndex == 1 ? Color.green.opacity(1) : Color.green.opacity(0.1), lineWidth: selectIndex == 1 ? 3 : 0)
                            )
                    }
                }
                
                Section {
                    Button("删除该模式") {
                        
                    }
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity)
                }
            }
            .sheet(isPresented: $isPresentEdit) {
                AddModeNamePage()
            }
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
                        .foregroundStyle(.black)
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
                    .foregroundStyle(Color.black.opacity(0.2))
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
        return NavigationLink {
            AddCycleTimePage(isOpen: .constant(true))
        } label: {
            VStack {
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
}

#Preview {
    ModeSettingPage()
}
