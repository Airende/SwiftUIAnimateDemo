//
//  SheetTimeView.swift
//  ZYLockMe
//
//  Created by 聪少 on 2024/9/5.
//

import SwiftUI
import SlidingRuler

struct SheetTimeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
    SheetTimeView()
}
