//
//  ModeLockView.swift
//  swiftUIDemo
//
//  Created by AiMac on 2024/8/19.
//

import SwiftUI

struct ModeLockView: View {
    @State private var inputPassword: String = ""
    @State private var shakingInterval: CGFloat = 0
    @FocusState private var isFocus: Bool

    @Binding var openPassword: String
    @Binding var unlockSuccess: Bool
    @Binding var hideKeyboard: Bool
    
    
    
    var body: some View {
        VStack {
            Image(systemName: "faceid")
                .font(.system(size: 85))
                .opacity(0.95)
                .padding(.vertical, 5)
                .padding(.top, 180)
                .onTapGesture {
                    isFocus = false
                }
            ZStack {
                HStack(spacing: 16) {
                    ForEach(0..<4,id: \.self){ index in
                        PasswordView(circleFillColor: .white, circleStrokeColor: .white.opacity(0.85), circleSize: 16, index: index, password: $inputPassword)
                    }
                }
                .warning(shakingInterval)
                
                TextField("", text: $inputPassword)
                .keyboardType(.numberPad)
                .foregroundColor(.clear)
                .accentColor(.clear)
                .focused($isFocus)
                .onChange(of: inputPassword) { newValue in
                    if newValue == openPassword {
                        isFocus = false
                        unlockSuccess = true
                        inputPassword = ""
                    }else if newValue.count == 4 {
                        shakingInterval += 1
                        inputPassword = ""
                    }
                }
            }
            
            Text("此模式已锁定")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.top, 10)
            Text("点击通过faceId或者输入密码进行解锁")
                .font(.system(size: 16))
                .fontWeight(.regular)
                .padding(.top, 1)
            Spacer()
        }
        .onChange(of: hideKeyboard, perform: { newValue in
            isFocus = false
        })
        .background(
            FlowingColorView(clear: true)
        )
        .foregroundStyle(Color.white)
        .onTapGesture {
            isFocus = false
        }
    }
}

fileprivate
extension View {
    func warning(_ interval: CGFloat) -> some View {
        self.modifier(WarningEffect(interval))
            .animation(Animation.default, value: interval)
    }
}

fileprivate
struct WarningEffect: GeometryEffect {
    
    var animatableData: CGFloat
    var amount: CGFloat = 3
    var shakeCount = 6

    init(_ interval: CGFloat) {
        self.animatableData = interval
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * CGFloat(shakeCount) * .pi), y: 0))
    }
}

#Preview {
    ModeLockView(openPassword: .constant("1111"), unlockSuccess: .constant(false), hideKeyboard: .constant(false))
}
