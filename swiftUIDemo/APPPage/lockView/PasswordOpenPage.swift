//
//  PasswordOpenPage.swift
//  ZYLockMe
//
//  Created by AiMac on 2024/2/3.
//

import SwiftUI

struct PasswordOpenPage: View {
//    @AppStorage(kAPPOpenPassword) var appPassword: String?
    @State var appPassword: String?
    @Binding var isLock: Bool
    @State var password: String = ""
    @FocusState var isNameFocused: Bool
    @State var tipString: String = "输入密码"
        
    var body: some View {
        VStack(content: {
            Image(systemName: isLock ? "lock" : "lock.open")
                .font(.largeTitle)
                .padding(.top, 120)
                .onTapGesture(count: 15) {
                    appPassword = "1234"
                }
            Text(tipString)
                .padding(.top, 20)
                .foregroundStyle(.primary)
            ZStack{
                HStack(spacing: 20) {
                    ForEach(0..<4,id: \.self){ index in
                        PasswordView(index: index, password: $password)
                    }
                }

                TextField("", text: $password)
                    .onChange(of: password) { newValue in
                        if password.count == 4 {
                            if password != appPassword {
                                UINotificationFeedbackGenerator().notificationOccurred(.error)
                                tipString = "密码错误"
                                TimeTool.after(0.5) {
                                    password = ""
                                }
                            }else if password == appPassword {
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                                tipString = "解锁成功"
                                isNameFocused = false
                                TimeTool.after(0.5) {
                                    withAnimation(.easeInOut) {
                                        isLock = false
                                    }
                                }
                            }
                        }else if password.count == 1 {
                            tipString = "输入密码"
                        }

                    }
                .focused($isNameFocused)
                .keyboardType(.numberPad)
//                    .border(Color.black, width: 1)
                .foregroundColor(.clear)
                .accentColor(.clear)
                
                .onAppear{
                    password = ""
                    TimeTool.after(0.3) {
                        isNameFocused = true
                    }
                }
            }

            Spacer()
            HStack{
                Image(systemName: "info.circle")
                    .padding()
                    .foregroundStyle(.clear)
                Button("收起键盘") {
                    isNameFocused = false
                }
                .frame(maxWidth: .infinity)

                Image(systemName: "faceid")
                    .padding()
                    .foregroundStyle(.clear)
            }
        })
    }
}

#Preview {
    @State var l = false
    return PasswordOpenPage(isLock: $l)
}
