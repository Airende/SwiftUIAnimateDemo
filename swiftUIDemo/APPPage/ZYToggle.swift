//
//  ZYTogView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/9/3.
//

import SwiftUI

struct ZYToggle: View {
    @Binding var isOn: Bool
    var onColor: Color = .green
    var onTapReceive: ((Bool) -> Void)?
    @GestureState private var isTapped = false
    
    var backgroundColor: Color {
       isOn ? onColor : Color(hex: 0x333333)
    }
    
    var handleColor: Color {
       isOn ? Color(hex: 0xFFFFFF) : Color(hex: 0xDDDDDD)
    }
    
    var gesture: some Gesture {
       DragGesture(minimumDistance: 0)
          .updating($isTapped) { (_, isTapped, _) in
             isTapped = true
          }
          .onEnded { _ in
             isOn.toggle()
             onTapReceive?(isOn)
          }
    }
    
    var body: some View {
       switchUIView()
          .gesture(gesture)
          .animation(.default, value: isOn)
          .animation(.default, value: isTapped)
    }
    
    @ViewBuilder
    private func switchUIView() -> some View {
       GeometryReader { geo in
          let handleGap = geo.size.height * 0.075
          ZStack(alignment: isOn ? .trailing : .leading) {
             Capsule()
                .fill(backgroundColor)
             Capsule()
                .fill(handleColor)
                .padding(handleGap)
                .frame(width: handleWidth(geo.size))
                .shadow(color: Color.black.opacity(0.4),
                        radius: handleGap * 0.5,
                        x: 0,
                        y: 0)
          }
       }
       .frame(idealWidth: 51, idealHeight: 31)
    }
    
    private func handleWidth(_ size: CGSize) -> CGFloat {
       let w = size.width
       let h = size.height
       return isTapped ? h + (w - h) * 0.3 : h
    }
}

#Preview {
    ZYToggle(isOn: .constant(true))
}
