//
//  AddModeNamePage.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/20.
//

import SwiftUI
import MCEmojiPicker

struct AddModeNamePage: View {
    let fillColors: [Color] = [.green, .orange, .blue, .yellow, .purple]
    let emojiList: [String] = ["🎋", "👼🏻", "🏃🏻‍♀️", "🎓", "🏓", "🍀", "🏀", "🎮", "🚗", "🎨"]
    
    @State var modeName: String = ""
    @State var selectedEmojiText: String = "🎋"
    @State var selectedColor: Color = .green
    @State var isPresentedEmoji: Bool = false
    var body: some View {
        
        ScrollView {
            Text("为你的模式命名")
                .font(.system(size: 30))
                .fontWeight(.medium)
                .padding(.top, 50)
            
            Button(selectedEmojiText) {
                isPresentedEmoji.toggle()
            }
            .emojiPicker(isPresented: $isPresentedEmoji, selectedEmoji: $selectedEmojiText)
            .font(.system(size: 100))
            .padding(20)
//            .border(Color.black, width: 1)
            
            TextField("名称", text: $modeName)
                .font(.title2)
                .frame(height: 50)
                .background(Color(uiColor: UIColor.systemGroupedBackground))
                .multilineTextAlignment(.center)
                .cornerRadius(12)
                .padding(.horizontal, 40)
            
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    Circle()
                        .fill(fillColors[index])
                        .frame(width: 45)
                        .onTapGesture {
                            selectedColor = fillColors[index]
                        }
                        .overlay(
                            Circle()
                                .stroke(Color.green.opacity(1) , lineWidth: 3)
                                .frame(width: 45)
                                
                        )
                }
            }
            .padding(.top, 30)
            
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    Text(emojiList[index])
                        .font(.system(size: 32))
                        .frame(width: 45)
                        .onTapGesture {
                            selectedEmojiText = emojiList[index]
                        }
                }
            }
            .padding(.top, 10)
            
            HStack(spacing: 20) {
                ForEach(0..<5) { index in
                    Text(emojiList[index+5])
                        .font(.system(size: 32))
                        .frame(width: 45)
                        .onTapGesture {
                            selectedEmojiText = emojiList[index+5]
                        }
                }
            }
            .padding(.top, 1)
                
            Button(action: {
                
            }, label: {
                Text("下一步")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.white)
            })
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(selectedColor)
            .cornerRadius(12)
            .padding(.horizontal, 40)
                        
        }
       
    }
}

#Preview {
    AddModeNamePage()
}
