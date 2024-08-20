//
//  FaceIdOpenPage.swift
//  ZYLockMe
//
//  Created by AiMac on 2024/1/21.
//

import SwiftUI
import LocalAuthentication

struct FaceIDOpenPage: View {
    @Binding var isLock: Bool
    var body: some View {
        VStack {

            Button {
                self.lockView()
            }label: {
                Image(systemName: "faceid")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .font(.system(size: 40, weight: .light, design: .default))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(Color.init(uiColor: .link))
            }
            .padding(.top, 220)
            Spacer()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            self.lockView()
        }
    }
    
    func lockView(){
        let context = LAContext()
        var error : NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            let reson = "解锁"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reson) { success, error in
                if success {
                    isLock = false
                } else {
                    isLock = true
                }
            }
        } else {
            print("\(error.debugDescription)")
            isLock = false
        }
    }
}

#Preview {
    @State var lockState: Bool = true
    return FaceIDOpenPage(isLock: $lockState)
}
