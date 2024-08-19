//
//  ModeLockView.swift
//  swiftUIDemo
//
//  Created by AiMac on 2024/8/19.
//

import SwiftUI

struct ModeLockView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "faceid")
                .font(.system(size: 85))
                .opacity(0.9)
                .padding(.vertical, 10)
                .padding(.top, 150)
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.white)
                .frame(width: 100, height: 20)
            Text("此模式已锁定")
                .font(.title3)
                .fontWeight(.bold)
            Text("使用faceId或者输入密码进行解锁")
                .fontWeight(.medium)
                .padding(.top, 1)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            FlowingColorView(clear: false)
        )
    }
}

#Preview {
    ModeLockView()
}
