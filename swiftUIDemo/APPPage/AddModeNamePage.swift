//
//  AddModeNamePage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/20.
//

import SwiftUI
import MCEmojiPicker

struct AddModeNamePage: View {
    private let characterLimit = 5
    let fillColors: [Color] = [.heiD, .lanD, .ziD, .hongD, .fenD, .huangD, .fenziD, .chengD, .lvD, .qingD]
    let emojiList: [String] = ["📚", "🎨", "🏀", "🚘", "🎮", "🐶", "👶🏻","🏃🏼", "🧘🏼", "🌏"]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var modeName: String = ""
    @State var selectedEmoji: String = "📚"
    @State var selectedEmojiIndex: Int = 0
    @State var selectedColorIndex: Int = 0
    @State var isPresentedEmoji: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                Text("为你的模式命名")
                    .font(.system(size: 30))
                    .fontWeight(.medium)
                    .padding(.top, 30)
                
                Button(selectedEmoji) {
                    isPresentedEmoji.toggle()
                    selectedEmojiIndex = -1
                }
                .emojiPicker(isPresented: $isPresentedEmoji, selectedEmoji: $selectedEmoji)
                .font(.system(size: 100))
                .padding(20)
                
                TextField("名称", text: $modeName)
                    .font(.title2)
                    .frame(height: 50)
                    .background(fillColors[selectedColorIndex].opacity(0.1))
                    .multilineTextAlignment(.center)
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
                    .onChange(of: modeName) { newValue in
                        if newValue.count > characterLimit {
                            modeName = String(newValue.prefix(characterLimit))
                        }
                    }
                
                LazyVGrid(columns: columns ,spacing: 20) {
                    ForEach(0..<fillColors.count) { index in
                        Circle()
                            .fill(fillColors[index])
                            .frame(width: 45)
                            .scaleEffect(selectedColorIndex == index ? 0.8 : 1)
                            .onTapGesture {
                                selectedColorIndex = index
                            }
                            .overlay(
                                Circle()
                                    .stroke(selectedColorIndex == index ? fillColors[selectedColorIndex].opacity(1) : Color.green.opacity(0), lineWidth: 3)
                                    .frame(width: 45)
                            )
                            
                    }
                }
                .padding(.horizontal, 37)
                .padding(.top, 20)
                
                LazyVGrid(columns: columns ,spacing: 20) {
                    ForEach(0..<emojiList.count) { index in
                        Text(emojiList[index])
                            .scaleEffect(selectedEmojiIndex == index ? 0.8 : 1)
                            .font(.system(size: 32))
                            .frame(width: 45)
                            .onTapGesture {
                                selectedEmojiIndex = index
                                selectedEmoji = emojiList[index]
                            }
                            
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedEmojiIndex == index ? fillColors[selectedColorIndex].opacity(1) : Color.green.opacity(0), lineWidth: 3)
                                    .frame(width: 45)
                            )
                    }
                }
                .padding(.horizontal, 37)
                .padding(.vertical, 20)
                
                NavigationLink {
                    ModeSettingPage()
                } label: {
                    Text("下一步")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(fillColors[selectedColorIndex])
                .cornerRadius(12)
                .padding(.horizontal, 40)
            }
            .navigationTitle("")
            .animation(.easeIn(duration: 0.15), value: selectedColorIndex)
            .animation(.easeIn(duration: 0.15), value: selectedEmojiIndex)
        }
    }
}

#Preview {
    AddModeNamePage()
}
