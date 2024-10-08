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
        NavigationStack {
            ZStack {
                ScrollView {
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
                        ForEach(0..<5) { index in
                            self.infoCell()
                        }
                    }
                    .frame(maxWidth: .infinity)
    //                .frame(height: 499)
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        
                    } label: {
                        Text("兑换")
                    }

                }
            }
        }
    }
    
    func skuCell(title: String, bottomText: String, curPrice: CGFloat, isSelect: Bool) -> some View{
        return VStack(spacing: 0){
            Text(title)
                .padding(.vertical, 15)
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundStyle(isSelect ? Color.heiD : Color.primary.opacity(0.6))
            Text("\(String(format: "¥%.2f", curPrice))")
                .font(.title2)
                .fontWeight(isSelect ? .semibold : .regular)
                .foregroundStyle(isSelect ? Color.heiD : Color.primary.opacity(0.6))
            Text(bottomText)
                .padding(.top, 15)
                .padding(.bottom, 15)
                .font(.callout)
                .fontWeight(.regular)
                .foregroundStyle(isSelect ? Color.heiD : Color.primary.opacity(0.6))

        }
        .frame(maxWidth: .infinity)
        .overlay(
            //圆角
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelect ? Color.heiD.opacity(1) : Color.heiD.opacity(0.1), lineWidth: isSelect ? 5 : 0)
        )
        .background( isSelect ? Color.blue.opacity(0.05) : Color.gray.opacity(0.05))
        .cornerRadius(10.0)
//        .padding(.horizontal, 20)
    }
    
    func infoCell() -> some View {
        return HStack {
            Image(systemName: "clipboard")
                .resizable()
                .frame(width: 20,height: 30)
                .padding(.leading, 20)
                .padding(.bottom, 5)
                .frame(maxHeight: .infinity)
                .foregroundStyle(Color.primary)
            HStack {
                VStack(alignment: .leading) {
                    Text("11")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("2dddddddd2")
                        .padding(.bottom, 10)
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding(.leading, 10)
            .padding(.vertical, 5)
            
            Spacer()
        }
    }
    
    func buyButton() -> some View {
        return VStack(spacing: 0) {
            Divider()
                .frame(height: 1)
            Text("\(selectIndex == 1 ? "每天仅需¥0.2，随时取消" : (selectIndex == 2 ? "每天仅需¥0.1，随时取消" : "¥\(foreverPrice) 一次性购买，无需订阅"))")
                .font(.system(size: 13))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
//                .background(Color.yellow)
                .foregroundStyle(
                    Color.heiD.opacity(0.8)
                )
            Button(action: {
                
                
            }, label: {
                Text("立即购买")
                    .padding()
                    .foregroundStyle(.baiD)
                    .frame(maxWidth: .infinity)
                    .background(Color.heiD)
            })
            .frame(maxWidth: .infinity)
            .cornerRadius(10.0)
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
        }
        .background( Color.init(uiColor: UIColor.systemBackground))
    }
}

#Preview {
    BuyVIPPage()
}
