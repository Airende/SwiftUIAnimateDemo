//
//  Joystick.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/5.
//

import SwiftUI

struct Joystick: View {
    let texts: [String] = ["First","Second","Third"]

    @State private var currentPageIndex = 0
    @State var paddingInsets: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    @State var editing: Bool = false
    
    var body: some View {
        
        ZStack(){
            TabView(selection: $currentPageIndex) {
                ForEach(Array(texts.enumerated()), id: \.offset) { index, string  in
                    if editing {
                        Text(string)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.random)
                            .tag(index)
                    }else{
                        if index == currentPageIndex {
                            Text(string)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.random)
                                .tag(index)
                        }
                    }
                }
            }
            .scrollDisabled(true)
            .cornerRadius(36)
            .padding(paddingInsets)
            .frame(height: UIScreen.main.bounds.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: editing ? .always : .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
            .onTapGesture(count: 1, perform: {
                withAnimation(.spring) {
                    self.editing = false
                    self.paddingInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                }
            })
            
            .onChange(of: currentPageIndex, perform: { oldValue in
                print(currentPageIndex)
            })
            

            .onLongPressGesture(minimumDuration: 1.5, maximumDistance: 2) {
                print("长按")
                withAnimation(.spring) {
                    self.editing = true
                    self.paddingInsets = .init(top: 100, leading: 30, bottom: 100, trailing: 30)
                }
            } onPressingChanged: { change in
                print("长按改变\(change)")
            }
            .ignoresSafeArea()
            .background(Color.black)
            
            topTitleView(texts[currentPageIndex])
            bottomEditView()
            
        }
        .background(Color.black)
    }
    
    //顶部标题
    func topTitleView(_ title: String) -> some View {
        return VStack{
            Text(title)
                .font(.title)
                .foregroundStyle(Color.white)
                .padding(40)
                .offset(y: editing ? 0 : -100)
                .opacity(editing ? 1 : 0)
                .animation(.easeInOut, value: editing)
            Spacer()
        }
    }
    
    func bottomEditView() -> some View {
        return VStack{
            Spacer()
            ZStack(content: {
                Button(action: {
                    print("点击编辑")
                }, label: {
                    Text("编辑")
                        .frame(width: UIScreen.main.bounds.width/2, height: 50)
                        .background {
                            Color.yellow
                        }
                        .cornerRadius(25)
                })
                .padding()

                HStack {
                    Spacer()
                    Button(action: {
                        print("添加")
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .background(content: {
                                Color.green
                            })
                            .cornerRadius(25)
                            .frame(width: 50, height: 50)
                    })
                    .background(content: {
                        Color.blue
                    })
                    .frame(width: 45, height: 45)
                    .cornerRadius(40)
                    .padding(.trailing, 40)
                }
                .padding(0)
            })
            .padding(.bottom, 20)
            .background(Color.black)
            .offset(y: editing ? 0 : 200)
            .opacity(editing ? 1 : 0)
            .animation(.easeInOut, value: editing)
        }
    }
}

enum JoyStickState: String {
    case up
    case down
    case left
    case right
    case center
}

struct JoyStickView: View {
    let iconPadding: CGFloat = 10
    
    @State var locationX: CGFloat = 0
    @State var locationY: CGFloat = 0
    
    @State private var joyStickState: JoyStickState = .center
    @State private var isShowAnimation: Bool = false
    
    
    var body: some View {
        Text("1111")
    }
}


#Preview {
    Joystick()
}
