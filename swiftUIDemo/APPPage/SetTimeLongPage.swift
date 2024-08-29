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
    @State private var isPresented: Bool = false
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

struct SheetTimePointConstants: View {
    @Binding var constants: ASConstant
    @State var timeLong: CGFloat = 0
    @State var selectedDate: Date = .now+60*25
    
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
            Text("专注到：")
            Text("\(self.formatDateToShanghai(selectedDate, dateFormat: "HH:mm"))")
//                .foregroundColor(Color(hex: "#BFC7D7").opacity(1))
                .foregroundColor(Color.blue.opacity(0.5))
                .fontWeight(.medium)
                .font(.system(size: 120))
                .overlay {
                    DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .scaleEffect(7)
                        .opacity(0.02)
                        .offset(x: -7, y: 5)
                }
            Button("开始专注", action: {
                
            })
            .frame(height: 60)
            .padding(.horizontal,80)
            .background(Color.green)
            .cornerRadius(30)
            .padding(.bottom, 60)
        }
        
        .offset(y: 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
    func formatDateToShanghai(_ date: Date, dateFormat: String = "HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai") // 设置时区为上海
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}

struct SheetTimeLongConstants: View {
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

struct SheetTimeLongView: View {
    @Binding var timeLong: CGFloat
//    @State private var value: Double = 88

    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return f
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack (alignment: .bottom, content: {
                Group {
                    Text("\(Int(timeLong))")
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 100))
                    Text("min")
                        .fontWeight(.regular)
                        .font(.system(size: 50))
                        .offset(y: -10)
                }
                .offset(x: 42)
                .foregroundColor(Color(hex: "#BFC7D7").opacity(1))
            })
            SlidingRuler(value: $timeLong,
                         in: 0...120,
                         step: 10,
                         snap: .fraction,
                         tick: .fraction,
                         formatter: formatter)
        }        
    }
}

struct SheetTimePointView: View {
    @Binding var selectedDate: Date
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return f
    }
    
    var body: some View {
        VStack {
            Text("\(Date.formatDateToShanghai(selectedDate, dateFormat: "HH:mm"))")
                .foregroundColor(Color.blue.opacity(0.5))
                .fontWeight(.medium)
                .font(.system(size: 100))
                .overlay {
                    DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .scaleEffect(4)
                        .opacity(0.011)
                        .offset(x: -7, y: 5)
                }

        }
    }
}

extension Date {
    static func formatDateToShanghai(_ date: Date, dateFormat: String = "HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai") // 设置时区为上海
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}

#Preview {
    SetTimeLongPage()
}
