//
//  SetNewPassWordView.swift
//  ZYLockMe
//
//  Created by AiMac on 2024/2/3.
//

import SwiftUI

struct ResetPasswordPage: View {
    @Environment(\.presentationMode) var mode
//    @AppStorage(kAPPOpenPassword) var appPassword: String?
    @State var appPassword: String?
    @State var password: String = ""
    @FocusState var isNameFocused: Bool
    @State var isChangePassword = false
    @State var tipString: String = ""
    @State var count = 1
    @State var tempNewPassword = ""
    @State private var shakingInterval: CGFloat = 0

        
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                HStack(alignment: .center, content: {
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("关闭")
                    })
                    .padding(.horizontal, 20)
                    
                    Text(isChangePassword ? "修改密码" : "设置密码")
                        .font(.system(size: 22))
                        .fontWeight(.regular)
                        .padding()
                        .onTapGesture(count: 3, perform: {
                            appPassword = "1234"
                            isChangePassword = false
                        })
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                    }, label: {
                        Text("占位")
                    })
                    .foregroundStyle(.clear)
                    .padding(.horizontal, 20)
                })

                Text(tipString)
                    .font(.system(size: 16))
                    .padding(.top, 90)
                    .padding(.bottom, 30)
                ZStack{
                    HStack(spacing: 20) {
                        ForEach(0..<4,id: \.self){ index in
                            PasswordView(index: index, password: $password)
                        }
                    }
                    .warning(shakingInterval)

                    TextField("", text: $password)
                        .onChange(of: password) { newValue in
                            if isChangePassword && password.count == 4 {
                                if password != appPassword {
                                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                                    TimeTool.after(0.5) {
                                        tipString = "旧密码错误请重新输入"
                                        password = ""
                                        shakingInterval += 1
                                    }
                                }else if password == appPassword {
                                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                                    TimeTool.after(0.5) {
                                        isChangePassword = false
                                        tipString = "请输入新密码"
                                        password = ""
                                    }
                                }
                            }else{
                                if password.count == 4 {
                                    if count == 1 {
                                        //第一次输入新密码
                                        tempNewPassword = password
                                        count = 2
                                        TimeTool.after(0.5) {
                                            tipString = "请再次输入新密码"
                                            password = ""
                                        }
                                        
                                    }else if count == 2, tempNewPassword == password {
                                        //再次输入成功
                                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                                        tipString = "密码设置成功"
                                        appPassword = tempNewPassword
                                        TimeTool.after(0.5) {
                                            self.mode.wrappedValue.dismiss()
                                        }
                                    }else if count == 2,
                                             password.count == 4,
                                             tempNewPassword != password {
                                        UINotificationFeedbackGenerator().notificationOccurred(.error)

                                        //再次输入错误
                                        tipString = "密码不一致请从新输入"
                                        tempNewPassword = ""
                                        count = 1
                                        shakingInterval += 1
                                        TimeTool.after(0.5) {
                                            password = ""
                                        }
                                    }
                                    
                                }
                            }
                            print("===\(password)")
                        }

//                    .opacity(0)
                    .focused($isNameFocused)
                    .keyboardType(.numberPad)
                    .foregroundColor(.clear)
                    .accentColor(.clear)
                    .onAppear{
                        if appPassword?.count == 4 {
                            self.isChangePassword = true
                        }

                        TimeTool.after(0.3) {
                            isNameFocused = true
                        }
                    }
                }
                Spacer()
            })
            .onAppear(perform: {
                if appPassword?.count == 4 || isChangePassword {
                    tipString = "请输入旧密码"
                }else{
                    tipString = "请设置密码"
                }
            })
        })

    }
}

class TimeTool {
    //延时
    class func after(_ time: CGFloat, complete:@escaping ()->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + time){
            complete()
        }
    }
}

#Preview {
    return ResetPasswordPage()
}
