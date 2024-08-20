//
//  PasswordView.swift
//  AppLock
//
//  Created by Liu Chuan on 2020/10/19.
//

import SwiftUI

/// 密码视图（小圆）
struct PasswordView : View {
    var circleFillColor: Color = .blue
    var circleStrokeColor: Color = .blue
    var circleSize: CGFloat = 20

    var index : Int
    /// 密码
    @Binding var password : String
    
    var body: some View{
        ZStack {
            Circle()
                .stroke(circleStrokeColor,lineWidth: 2)
                .frame(width: circleSize, height: circleSize)
            // 检查是否正在输入...
            if password.count > index {
                Circle()    // 填充白色圆
                    .fill(circleFillColor)
                    .frame(width: circleSize, height: circleSize)
            }
        }
    }
}

#Preview {
    @State var s = "1"
    return PasswordView(index: 1, password: $s)
}
