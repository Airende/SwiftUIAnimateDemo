//
//  BuyVIPPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/16.
//

import SwiftUI

struct BuyVIPPage: View {
    private let moonPrice: CGFloat = 6.00
    private let yearPrice: CGFloat = 38.00
    private let foreverPrice: CGFloat = 48.00
    @State var selectIndex: Int = 1
    
    var body: some View {
        ZStack {
//            FlowingColorView()
            ScrollView {
                HStack {
                    Text("✖️")
                        .font(.system(size: 35))
                        .padding(.leading, 20)
                    Spacer()
                    Text("兑换")
                        .padding(.trailing, 20)
                        .foregroundColor(.blue)
                }
                Text("🐰")
                    .font(.system(size: 100))
                Text("市值风云 🥕")
                    .font(.system(size: 30))
                Text("升级为pro解锁全部好用功能")
                    .foregroundStyle(Color.gray)
                HStack {
                    self.skuCell(title: "月度会员", bottomText: "连续\n包月", curPrice: moonPrice, isSelect: selectIndex == 1)
                        .onTapGesture {
                            selectIndex = 1
                        }
                    self.skuCell(title: "年度会员", bottomText: "连续\n包年", curPrice: yearPrice, isSelect: selectIndex == 2)
                        .onTapGesture {
                            selectIndex = 2
                        }
                    self.skuCell(title: "永久会员", bottomText: "最大\n优惠", curPrice: foreverPrice, isSelect: selectIndex == 3)
                        .onTapGesture {
                            selectIndex = 3
                        }
                }
                .padding(.all, 20)
                
                VStack {
                    Text("1111")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 499)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(20)
                .padding(20)
                
                Spacer()
                    .padding(.bottom, 100)
            }
            VStack {
                Spacer()
                buyButton()
            }
        }
        
    }
    
    func skuCell(title: String, bottomText: String, curPrice: CGFloat, isSelect: Bool) -> some View{
        return VStack(spacing: 0){
            Text(title)
                .padding(.vertical, 15)
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundStyle(isSelect ? Color.blue : Color.primary.opacity(0.7))
            Text("\(String(format: "¥%.2f", curPrice))")
                .font(.title2)
                .fontWeight(.regular)
                .foregroundStyle(isSelect ? Color.blue : Color.primary.opacity(0.7))
            Text(bottomText)
                .padding(.top, 15)
                .padding(.bottom, 15)
                .font(.callout)
                .fontWeight(.regular)
                .foregroundStyle(isSelect ? Color.blue : Color.primary.opacity(0.7))

        }
        .frame(maxWidth: .infinity)
        .overlay(
            //圆角
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelect ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1), lineWidth: isSelect ? 5 : 0)
        )
        .background( isSelect ? Color.blue.opacity(0.05) : Color.gray.opacity(0.05))
        .cornerRadius(10.0)
//        .padding(.horizontal, 20)
    }
    
    func buyButton() -> some View {
        return VStack(spacing: 0) {
            Divider()
                .frame(height: 1)
            Text("\(selectIndex == 1 ? "每天仅需¥0.2，随时取消" : (selectIndex == 2 ? "每天仅需¥0.1，随时取消" : "¥\(foreverPrice) 一次性购买，无需订阅"))")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
//                .background(Color.yellow)
                .foregroundStyle(
                    Color.gray.opacity(0.8)
                )
            Button(action: {
                
                
            }, label: {
                Text("立即购买")
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
            })
            .frame(maxWidth: .infinity)
            .cornerRadius(10.0)
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
        }
        .background( Color.white )
    }
}

#Preview {
    BuyVIPPage()
}
