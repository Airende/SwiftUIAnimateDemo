//
//  LockedPageView.swift
//  ZYLockMe
//
//  Created by AiMac on 2024/1/21.
//

import SwiftUI

/// 锁屏页面
struct LockedPageView : View {
    // AppStorage: 属性包装程序类型 -> UserDefaults.  在用户单击“删除”时更改它
    @AppStorage("lock_Password") var key = "2222"
    @Binding var locked : Bool
    @State var password = ""
    @State var wrongPassword = false
    
    let height = UIScreen.main.bounds.width
  
    var body: some View {
        VStack{
            HStack{
                Spacer(minLength: 0)
                Menu(content: {
                    Label(
                        title: { Text("帮助") },
                        icon: { Image(systemName: "info.circle.fill")})
                        .onTapGesture(perform: {
                            // perform actions...
                        })
                    Label(
                        title: { Text("重置密码") },
                        icon: { Image(systemName: "key.fill") })
                        .onTapGesture(perform: {
                            // perform actions...
                        })
                }) {
                    Image(systemName: "gearshape.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.cyan)
                        .padding()
                }
            }.padding(.leading)
            
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .scaleEffect(CGSize(width: 2, height: 2))
                .frame(width: 100, height: 100)
            
            Text(wrongPassword ? "密码错误请重试" : "输入密码解锁")
                .font(.system(size: 18, weight: .thin, design: .default))
                .fontWeight(.heavy)
                .padding(.top,10)
                .foregroundColor(wrongPassword ? .red : .white)
            
            HStack(spacing: 20) {
                ForEach(0..<4,id: \.self){ index in
                    PasswordView(index: index, password: $password)
                }
            }
            // 对于较小尺寸的iPhone.
            .padding(.top,height < 750 ? 20 : 30)
            
            // 键盘....
                    
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: height < 750 ? 10 : 15) {
                // Password Button ....
                ForEach(1...9, id: \.self){value in
                    PasswordButton(value: "\(value)",password: $password, key: $key, unlocked: $locked, wrongPass: $wrongPassword)
                }
                PasswordButton(value: "取消", password: $password, key: $key, unlocked: $locked, wrongPass: $wrongPassword)
                PasswordButton(value: "0", password: $password, key: $key, unlocked: $locked, wrongPass: $wrongPassword)
                PasswordButton(value: "delete.fill",password: $password, key: $key, unlocked: $locked, wrongPass: $wrongPassword)
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 20)
            Spacer()
                .onChange(of: password) { newValue in
                    print("当前输入\(password)")
                }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}


#Preview {
    @AppStorage("APPIsLock") var isLock: Bool = false
    return LockedPageView(locked: $isLock)
}
