//
//  SetTimeLongPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/27.
//

import SwiftUI
import AxisSheet
import SlidingRuler

struct SetTimeLongPage: View {
    @State private var isPresented: Bool = true
    @State private var constants = ASConstant(axisMode: .bottom, size: UIScreen.main.bounds.height*0.5, background: .init(disabled: false))
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            AxisSheet(isPresented: $isPresented, constants: constants) {
                SheetConstants(constants: $constants)
            }
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
    
    @State private var value: Double = .zero

    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 0
        return f
    }
    
    var body: some View {
        VStack {
            HStack (alignment: .bottom, content: {
                Group {
                    Text("13")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 120))
                    Text("min")
                        .fontWeight(.regular)
                        .font(.system(size: 60))
                        .offset(y: -15)
                }
                .foregroundColor(Color(hex: "#BFC7D7").opacity(1))
            })
            SlidingRuler(value: $value,
                         in: 0...1,
                         step: 0.1,
                         snap: .fraction,
                         tick: .fraction,
                         formatter: formatter)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        
    }
}

#Preview {
    SetTimeLongPage()
}
