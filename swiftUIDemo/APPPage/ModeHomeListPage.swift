//
//  ModeHomeListPage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/29.
//

import SwiftUI
import ColorfulX

struct ModeHomeListPage: View {
    let texts: [String] = ["First","Second","Third"]
    @State private var currentPageIndex = 0
    @State var paddingInsets: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    @State var editing: Bool = false
    
    var body: some View {
        NavigationView(content: {
            ZStack(){
                TabView(selection: $currentPageIndex) {
                    ForEach(Array(texts.enumerated()), id: \.offset) { index, string  in
                        TimeModeMainPage(isEditing: $editing)
                            .background( editing ? Color.clear : Color.white)
                            .tag(index)
                            .tabItem {
                                Image(systemName: "leaf")
                            }
                    }
                }
                .padding(.top, editing ? 0 : -20)
                .padding(paddingInsets)
                .frame(height: UIScreen.main.bounds.height)
                .cornerRadius(36)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                .onTapGesture(count: 1, perform: {
                    self.becomeEdit(false)
                })
                .onLongPressGesture(perform: {
                    self.becomeEdit(true)
                })
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: editing ? .automatic : .never))
//                .ignoresSafeArea()
                .overlay(content: {
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    self.editing = true
                                    self.paddingInsets = .init(top: 100, leading: 30, bottom: 100, trailing: 30)
                                }
                            }, label: {
                                Image(systemName: "slider.horizontal.3")
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                            })
                            
                            NavigationLink {
                                MySettingPage()
                            } label: {
                                Image(systemName: "square.rightthird.inset.filled")
                                    .padding(.trailing, 15)
                                    .padding(.top, 10)
                            }
//                            .border(.red, width: 1)
                        }
                        .foregroundStyle(Color.black.opacity(0.8))
                        Spacer()
                        
                    }
                    .opacity(editing ? 0 : 1)
                    .padding(.top, 40)
                })
                
                topTitleView(texts[currentPageIndex])
                bottomEditView()
            }
            .background {
                if editing {
                    FlowingColorView(clear: true, colors: ColorfulExtentsion.blackBlue.colors)
                }
            }
            .animation(.easeInOut, value: editing)
        })
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func becomeEdit(_ isEdit: Bool){
        withAnimation(.easeInOut) {
            if isEdit {
                self.editing = true
                self.paddingInsets = .init(top: 100, leading: 30, bottom: 100, trailing: 30)
            }else{
                self.editing = false
                self.paddingInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            }
        }
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
            HStack(content: {
                Button(action: {
                    self.becomeEdit(false)
                }, label: {
                    Image(systemName: "checkmark.circle.fill")
                        .background(content: {
                            Color.white.opacity(0.9)
                        })
                        .font(.system(size: 30))
                        .cornerRadius(25)
                })
                .frame(width: 45, height: 45)
                
                NavigationLink(destination: ModeSettingPage()) {
                    Text("编辑")
                        .frame(width: UIScreen.main.bounds.width/2, height: 50)
                        .background {
                            Color.yellow
                        }
                        .cornerRadius(25)
                }
                .padding()

                NavigationLink(destination: AddModeNamePage()) {
                    Image(systemName: "plus.circle.fill")
                        .background(content: {
                            Color.white.opacity(0.9)
                        })
                        .font(.system(size: 30))
                        .cornerRadius(25)
                }
                .frame(width: 45, height: 45)
            })
            .padding(.bottom, 20)
            .offset(y: editing ? 0 : 200)
            .opacity(editing ? 1 : 0)
            .animation(.easeInOut, value: editing)
        }
    }
}

#Preview {
    ModeHomeListPage()
}
