//
//  AxisSheetDemo.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/26.
//

import SwiftUI
import AxisSheet

struct AxisSheetDemo: View {
    @State private var isPresented: Bool = false
    @State private var constants = ASConstant()
    @State private var isCustomHeader: Bool = false
    
    private var customHeader: some View {
        Rectangle().fill(Color.red.opacity(0.5))
            .overlay(
                HStack {
                    Text("Header")
                        .frame(width: 160)
                        .foregroundColor(.white)
                        .rotationEffect(getHeaderAngle())
                }
            )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SheetControls(isPresented: $isPresented,
                          constants: $constants,
                          isCustomHeader: $isCustomHeader)
                .padding()
            ZStack {
                VStack {
                    Text("AxisSheet")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Text("for SwiftUI")
                        .font(.headline)
                        .opacity(0.5)
                }
                .foregroundColor(.accentColor)
                .offset(getOffset())
                if !isCustomHeader {
                    AxisSheet(isPresented: $isPresented, constants: constants) {
                        SheetConstants(constants: $constants)
                    }
                }else {
                    SheetConstants(constants: $constants)
                        .axisSheet(isPresented: $isPresented, constants: constants) {
                            customHeader
                        }
                }
            }
            .background(Color.blue.opacity(0.26))
            .animation(.easeOut(duration: 0.2), value: constants)
        }
    }
    
    private func getHeaderAngle() -> Angle {
        switch constants.axisMode {
        case .top, .bottom: return Angle(degrees: 0)
        case .leading: return Angle(degrees: 90)
        case .trailing: return Angle(degrees: -90)
        }
    }
    
    private func getOffset() -> CGSize {
        guard constants.presentationMode == .minimize else {
            return .zero
        }
        switch constants.axisMode {
        case .top:       return CGSize(width: 0, height: constants.header.size)
        case .bottom:    return CGSize(width: 0, height: -constants.header.size)
        case .leading:   return CGSize(width: constants.header.size, height: 0)
        case .trailing:  return CGSize(width: -constants.header.size, height: 0)
        }
    }
}

fileprivate
struct SheetConstants: View {
    
    @Binding var constants: ASConstant
    
    init(constants: Binding<ASConstant>) {
        _constants = constants
        UITableView.appearance().backgroundColor = .clear
    }
    
    var content: some View {
        Group {
            Section(header: Text("Header").foregroundColor(.accentColor)) {
                SheetSlider(title: "size", value: $constants.header.size, range: 24...70)
                SheetSlider(title: "shortAxis", value: $constants.header.shortAxis, range: 0...10)
                SheetSlider(title: "longAxis", value: $constants.header.longAxis, range: 0...80)
                SheetSlider(title: "radius", value: $constants.header.cornerRadius, range: 0...(constants.header.size / 2))
                ColorPicker("foregroundColor", selection: $constants.header.color)
                ColorPicker("backgroundColor", selection: $constants.header.backgroundColor)
            }
            
            Section(header: Text("Content").foregroundColor(.accentColor)) {
                SheetSlider(title: "size", value: $constants.size, range: 200...500)
            }
            
            Section(header: Text("Background").foregroundColor(.accentColor)) {
                Toggle("disabled", isOn: $constants.background.disabled)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                ColorPicker("color", selection: $constants.background.color)
            }
        }
        .foregroundColor(Color.white)
        .listRowBackground(Color.clear)
    }
    var body: some View {
        ZStack {
            Form {
                content
            }
        }
        .background(
            ZStack {
                Color.gray
                Color.black.opacity(0.75)
            }
        )
    }
}

fileprivate
struct SheetControls: View {
    
    @Binding var isPresented: Bool
    @Binding var constants: ASConstant
    @Binding var isCustomHeader: Bool
    
    var body: some View {
        HStack {
            Toggle("", isOn: $isPresented)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .labelsHidden()
            VStack(alignment: .trailing) {
                Picker("", selection: $constants.axisMode) {
                    Image(systemName: "rectangle.bottomthird.inset.filled").tag(ASAxisMode.bottom)
                    Image(systemName: "rectangle.rightthird.inset.filled").tag(ASAxisMode.trailing)
                    Image(systemName: "rectangle.leadingthird.inset.filled").tag(ASAxisMode.leading)
                    Image(systemName: "rectangle.topthird.inset.filled").tag(ASAxisMode.top)
                }
                Picker("", selection: $constants.presentationMode) {
                    Text("Minimize").tag(ASPresentationMode.minimize)
                    Text("Hide").tag(ASPresentationMode.hide)
                }
                Picker("", selection: $isCustomHeader) {
                    Text("Normal").tag(false)
                    Text("Custom Header").tag(true)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }
}

fileprivate
struct SheetSlider: View {
    
    let title: String
    @Binding var value: CGFloat
    let range: ClosedRange<CGFloat>
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("\(value, specifier: "%.2f")")
                .font(.caption)
                .opacity(0.5)
            HStack {
                Text(title)
                Slider(value: $value, in: range)
            }
        }
    }
}

#Preview {
    AxisSheetDemo()
}
