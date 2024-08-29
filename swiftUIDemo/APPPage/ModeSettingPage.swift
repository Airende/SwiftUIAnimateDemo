//
//  ModeSettingPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/19.
//

import SwiftUI

struct ModeSettingPage: View {
    @State var selectIndex: Int = -1
    @State var isCycleTimeMode: Bool = true
    @State var usePassword: Bool = true
    @State var password: String = "123"
    
    @State var isPresentEdit: Bool = false
    
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
                                selectAppCell(title: "隐藏应用", apps: [1,2])
                            }
                            Divider()
                        }
                        .listRowSeparator(.hidden)
                        
                        Toggle(isOn: .constant(true)) {
                            Label("限制安装", systemImage:"plus.square.fill")
                               
                        }
                        Toggle(isOn: .constant(true)) {
                            Label("限制删除", systemImage:"minus.square.fill")
                        }
                        Toggle(isOn: .constant(true)) {
                            Label("限制支付", systemImage:"yensign.square.fill")
                        }
                    }
                    .foregroundStyle(Color.black.opacity(0.85))
                    .font(.system(size: 16))
                }
                
                
                Section("密码") {
                    Toggle("使用密码", isOn: $usePassword)
                    if usePassword {
                        HStack(spacing: 20) {
                            Text("密码设置")
                            Spacer()
                            ForEach(0..<4,id: \.self){ index in
                                PasswordView(circleFillColor: .green, circleStrokeColor: .green.opacity(0.85), circleSize: 10, index: index, password: $password)
                                    .padding(.horizontal, -5)
                            }
                            Image(systemName: "chevron.forward")
                        }
                    }
                }
                
                Section("时间设置") {
                    VStack {
                        HStack {
                            Text("时长模式")
                                .foregroundStyle( !isCycleTimeMode ? Color.green : Color.secondary)
                                .onTapGesture {
                                    isCycleTimeMode = false
                                }
                            Toggle("", isOn: $isCycleTimeMode)
                                .labelsHidden()
                                .frame(maxWidth: .infinity)
                            Text("周期模式")
                                .foregroundStyle( isCycleTimeMode ? Color.green : Color.secondary)
                                .onTapGesture {
                                    isCycleTimeMode = true
                                }
                        }
                        if isCycleTimeMode {
                            addTimeCycleCell(timeCycle: "9:00-10:00", weekly: "", isOpen: true)
                            addTimeCycleCell(timeCycle: "19:00-21:00", weekly: "", isOpen: false)
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
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.green)
                    .frame(width: 45, height: 45)
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
