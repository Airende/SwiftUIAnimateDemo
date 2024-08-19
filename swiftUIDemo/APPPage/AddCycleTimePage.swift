//
//  AddCycleTimePage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/19.
//

import SwiftUI

struct AddCycleTimePage: View {
    @Binding var isOpen: Bool
    @State var startChosen = Date()
    @State var selectArray: [Bool] = [true, true, true, true, true, true, true]
    var body: some View {
        NavigationView(content: {
            List {
                Section {
                    Toggle("使用定时", isOn: $isOpen)
                }
                
                Section {
                    HStack {
                        DatePicker(selection: $startChosen, in: Date()...Date()+1200, displayedComponents: .hourAndMinute) {
                            Text("从")
                        }
                        
                        DatePicker(selection: $startChosen, in: Date()...Date()+1200, displayedComponents: .hourAndMinute) {
                            Text("到")
                        }
                        .padding(.leading, 5)
                        Spacer()
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack(alignment: .center) {
                        ForEach(0..<7) { index in
                            Text("\(index)")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(selectArray[index] ? Color.green : Color.green.opacity(0.2))
                                .cornerRadius(30)
                                .onTapGesture {
                                    selectArray[index].toggle()
                                }
                            
//                                .border(Color.black, width: 1)
                        }
                    }
                    .padding(10)
                } footer: {
                    HStack {
                        Text(self.getWeeklyString())
                    }
                    
                }
                
                Section {
                    Button("删除定时") {
                        
                    }
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity)
                }
            }
        })
        .navigationTitle("定时")
    }
    
    func getWeeklyString() -> String {
        var weeklyStr: String = "每"
        var index: Int = 0
        for selected in self.selectArray {
            switch index {
            case 0: selected ? weeklyStr.append("周日、") : ()
            case 1: selected ? weeklyStr.append("周一、") : ()
            case 2: selected ? weeklyStr.append("周二、") : ()
            case 3: selected ? weeklyStr.append("周三、") : ()
            case 4: selected ? weeklyStr.append("周四、") : ()
            case 5: selected ? weeklyStr.append("周五、") : ()
            case 6: selected ? weeklyStr.append("周六") : ()
            default:
                break
            }
            index += 1
        }
        return weeklyStr.count == 1 ? "永不重复" : weeklyStr
    }
}

#Preview {
    @State var isOpen: Bool = false
    return AddCycleTimePage(isOpen: $isOpen)
}
