//
//  ModeLockView.swift
//  swiftUIDemo
//
//  Created by AiMac on 2024/8/19.
//

import SwiftUI

struct ModeLockView: View {
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            Image(systemName: "faceid")
                .font(.system(size: 85))
                .opacity(0.9)
                .padding(.vertical, 5)
                .padding(.top, 150)
                .foregroundStyle(Color.white.opacity(0.85))
            ZStack {
                HStack(spacing: 20) {
                    ForEach(0..<4,id: \.self){ index in
                        PasswordView(circleFillColor: .white, circleStrokeColor: .white.opacity(0.85), index: index, password: $password)
                    }
                }
                
                TextField("", text: $password)
    //            .focused($isNameFocused)
                .keyboardType(.numberPad)
//                .border(Color.black, width: 1)
                .foregroundColor(.clear)
                .accentColor(.clear)
            }
            
            Text("此模式已锁定")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)
            Text("点击通过faceId或者输入密码进行解锁")
                .font(.system(size: 16))
                .fontWeight(.medium)
                .padding(.top, 1)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            FlowingColorView(clear: false)
        )
        .foregroundStyle(Color.white)
    }
}

#Preview {
    ModeLockView()
}
