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
                SheetTimePointConstants(constants: $constants)
            }
        }
    }
}

fileprivate
struct SheetTimePointConstants: View {
    @Binding var constants: ASConstant
    @State var timeLong: CGFloat = 0
    @State var selected: Date = .now
    
    init(constants: Binding<ASConstant>) {
        _constants = constants
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State private var value: Double = .zero

    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return f
    }
    
    var body: some View {
        VStack {
            Text("\(selected.timeIntervalSince1970)")
                .foregroundColor(Color(hex: "#BFC7D7").opacity(1))
                .fontWeight(.medium)
                .font(.system(size: 30))
                .overlay {
                    DatePicker("", selection: $selected, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .font(.system(size: 120))
                        .scaleEffect(5)
                        .opacity(0.1)
                        
                }

            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.yellow)
                .frame(height: 60)
                .padding(.top, 40)
                .padding(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        
    }
}

fileprivate
struct SheetConstants: View {
    @Binding var constants: ASConstant
    @State var timeLong: CGFloat = 0
    
    init(constants: Binding<ASConstant>) {
        _constants = constants
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State private var value: Double = .zero

    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return f
    }
    
    var body: some View {
        VStack {
            HStack (alignment: .bottom, content: {
                Group {
                    Text("\(Int(value))")
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
            .padding(.top, 30)
            SlidingRuler(value: $value,
                         in: 0...120,
                         step: 10,
                         snap: .fraction,
                         tick: .fraction,
                         formatter: formatter)
            .padding()
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.yellow)
                .frame(height: 60)
                .padding(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        
    }
}

#Preview {
    SetTimeLongPage()
}
