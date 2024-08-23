//
//  Tube.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/23.
//

import SwiftUI
import CoreHaptics

struct Tube: View {
    let sliderHight: CGFloat = 50
    let sliderBorderW: CGFloat = 50/10.0
    //Slider properties
    @State var sliderProgress: CGFloat = 0
    @State var sliderWidth: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    // selected item index
    @State private var selectedMenu = 0
    
    // slide background position
    @State private var backgroundOffset: CGFloat = 0
    @State private var previousSelectedMenu = 0
    
    @State private var backgroundColor = Color(hex: "#A4FFEF")

    @State private var position = CGPoint(x: 100, y: 0)
    @State var maxSliderW: CGFloat = UIScreen.main.bounds.width-100
    
    @State var startAnimation: CGFloat = 0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let size = proxy.size
                ZStack {
                    //温度
                    ZStack {
                        VStack {
                            HStack (alignment: .bottom, content: {
                                Group {
                                    Text("\(Int((sliderProgress*(30))+20))")
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.trailing)
                                        .font(.system(size: 120))
                                    Text("min")
                                        .fontWeight(.regular)
                                        .font(.system(size: 60))
                                        .offset(y: -15)
                                }
                                .foregroundColor(Color(hex: "#BFC7D7").opacity(0.6))
                            })
                            Spacer()
                        }
                    }
                    
                    //刻度
                    ZStack (alignment: .leading, content: {
                        Rectangle()
                            .fill(Color(hex: "#DFE5F1").opacity(0.5))
                            .frame(height: sliderHight, alignment: .leading)
                        
                        Rectangle()
                            .fill(Color(hex: "#A1A7B4").opacity(0.8))
                            .frame(width: sliderWidth,height: sliderHight, alignment: .leading)
//                        Slider(value: $sliderHeight, in: 0...120, step: 1)
//                        .rotationEffect(.degrees(-90))
//                        .frame(width: 300)
//                        .padding(.horizontal, 50)
//                        .offset(y: -150)
//                        .border(Color.black, width: 1)
//                        .onChange(of: sliderHeight) { newValue in
//                            if abs(newValue - lastDragValue) >= 1 {
//                                lastDragValue = newValue
//                                triggerHapticFeedback()
//                            }
//                        }
                    })
                    .offset(y:-50)
                    
                    //阴影
                    ZStack {
                        RoundedRectangle(cornerRadius: 48)
                            .fill(
                                LinearGradient(colors: [
                                    Color(hex: "#55C1DC"),
                                    Color(hex: "#ABC770"),
                                    Color(hex: "#D7C05E"),
                                    Color(hex: "#EBAC38"),
                                    Color(hex: "#EF803B"),
                                    Color(hex: "#EE3A32"),
                                ], startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(height: sliderHight)
                            .frame(maxWidth: .infinity)
                            .blur(radius: 32)
                            .opacity(0.8)
                            .offset(x: 0, y: -sliderHight)
                        RoundedRectangle(cornerRadius: 48)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [
                                    Color(hex: "#FFFFFF"),
                                    Color(hex: "#ECECEC"),
                                ]), startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(height: sliderHight)
                            .frame(maxWidth: .infinity)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .opacity(0.8)
                    }
                    
                    //两层波浪
                    WaterWaveShape(progress: sliderProgress, waveHeight: 0.02, offset: startAnimation)
                        .fill(LinearGradient(gradient: Gradient(colors: [
                            Color(hex: "#55C1DC"),
                            Color(hex: "#ABC770"),
                            Color(hex: "#D7C05E"),
                            Color(hex: "#EBAC38"),
                            Color(hex: "#EF803B"),
                            Color(hex: "#EE3A32"),

                        ]), startPoint: .leading, endPoint: .trailing))
                        .frame(height: sliderHight)
                        .frame(maxWidth: .infinity)
                        .mask(
                            RoundedRectangle(cornerRadius: 48)
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color(red: 236/255, green: 234/255, blue: 235/255),
                                        lineWidth: 1)
                                .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 0)
                                .clipShape(
                                    Capsule()
                                )
                        )
                    WaterWaveShape(progress: sliderProgress, waveHeight: 0.02, offset: startAnimation+size.width/2)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [
                                Color(hex: "#55C1DC"),
                                Color(hex: "#ABC770"),
                                Color(hex: "#D7C05E"),
                                Color(hex: "#EBAC38"),
                                Color(hex: "#EF803B"),
                                Color(hex: "#EE3A32"),
                            ]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(height: sliderHight)
                        .frame(maxWidth: .infinity)
                        .mask(RoundedRectangle(cornerRadius: 48))
                        .opacity(0.5)
                    
                    //边框
                    RoundedRectangle(cornerRadius: 54)
                        .strokeBorder(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8), Color(red: 0.93, green: 0.94, blue: 0.97, opacity: 1)]), startPoint: .leading, endPoint: .trailing)
                            , lineWidth: sliderBorderW)
                        .frame(height: sliderHight)
                        .frame(maxWidth: .infinity)
                    
                    //上高光
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(height: 5)
                        .frame(maxWidth: .infinity)
                        .mask(RoundedRectangle(cornerRadius: 48))
                        .blur(radius: 3)
                        .opacity(0.5)
                        .blendMode(.overlay)
                        .offset(x: 0, y: -10)
                        .padding(30)
                    //下高光
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(height: 15)
                        .frame(maxWidth: .infinity)
                        .mask(RoundedRectangle(cornerRadius: 48))
                        .blur(radius: 4)
                        .opacity(0.3)
                        .blendMode(.overlay)
                        .offset(x: 0, y: 10)
                        .padding()
                }
                .frame(width: size.width, height: size.height, alignment: .center)
                .onAppear{
                    //Looping animation
                    withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)){
                        //loop will not finish if staranimation will be larger than rect width
                        startAnimation = size.width
                    }
                }
                
                ZStack {
                    VStack {
                        ZStack(alignment: .bottom, content: {
                            Rectangle()
                                .fill(Color(.gray).opacity(0.1))
                        })
                        .frame(width: maxSliderW, height: sliderHight)
                        .cornerRadius(48)
//                        .offset(x: 80, y:80)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ value in
                                    //getting dragvalue...
                                    let translation = value.translation
                                    
                                    sliderWidth = translation.width + lastDragValue
                                    
                                    //Limiing slide height value
                                    sliderWidth = sliderWidth > maxSliderW ? maxSliderW : sliderWidth
                                    
                                    sliderWidth = sliderWidth >= 0 ? sliderWidth : 0
                                    
                                    //updating progress
                                    let progres = sliderWidth / maxSliderW
                                    sliderProgress = progres <= 1.0 ? progres : 1
                                    switch sliderProgress {
                                    case 0..<0.5:
                                        backgroundColor = Color(hex: "#A4FFEF")
                                        selectedMenu = 0
                                    case 0.5..<0.8:
                                        backgroundColor = Color(hex: "#FFEDAE")
                                        selectedMenu = 1
                                    default:
                                        backgroundColor = Color(hex: "#FFC5C5")
                                        selectedMenu = 2
                                    }
                                })
                                .onEnded({ value in
                                    // Storing las drag value for restorating
                                    sliderWidth = sliderWidth > maxSliderW ? maxSliderW : sliderWidth
                                    // Negative height...
                                    sliderWidth = sliderWidth >= 0 ? sliderWidth : 0
                                    lastDragValue = sliderWidth
                                })
                        )
                    }
                    
                    .frame(width: maxSliderW, height: sliderHight, alignment: .center)
                    .zIndex(-1)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                .offset(y: 100)
                .border(Color.black, width: 1)
                
                VStack{
                    Spacer()
                    HStack(spacing: 20) {
                        MenuButton(label: "❄️", isSelected: selectedMenu == 0)
                            .scaleEffect(selectedMenu == 0 ? 1.2 : 1.0) // Scale up when selected
                            .onTapGesture {
                                backgroundColor = Color(hex: "#A4FFEF")
                                previousSelectedMenu = selectedMenu
                                sliderProgress = 0
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.selectedMenu = 0
                                }
                            }
                        MenuButton(label: "🪴", isSelected: selectedMenu == 1)
                            .scaleEffect(selectedMenu == 1 ? 1.2 : 1.0) // Scale up when selected
                            .onTapGesture {
                                backgroundColor = Color(hex: "#FFEDAE")
                                previousSelectedMenu = selectedMenu
                                sliderProgress = 0.5
                                withAnimation(.easeInOut(duration: 1))  {
                                    self.selectedMenu = 1
                                }
                            }
                        
                        MenuButton(label: "🔥", isSelected: selectedMenu == 2)
                            .scaleEffect(selectedMenu == 2 ? 1.2 : 1.0) // Scale up when selected
                            .onTapGesture {
                                backgroundColor = Color(hex: "#FFC5C5")
                                previousSelectedMenu = selectedMenu
                                self.selectedMenu = 2
                                withAnimation(.easeInOut(duration: 1)) {
                                    sliderProgress = 1
                                }
                            }
                    }
                    
                    .background(
                        GeometryReader { proxy in
                            let iconWidth = CGFloat(60) // change this to the actual width of your icon
                            let backgroundWidth = proxy.size.width / 3
                            let extraOffset = (proxy.size.width - backgroundWidth * 3 - 10) / 2 // calculate extra offset for first and last background
                            let menuOffset = CGFloat(selectedMenu) * (backgroundWidth + 10)
                            let centerOffset = (backgroundWidth - iconWidth) / 2
                            let leadingOffset = centerOffset + menuOffset + extraOffset * (selectedMenu == 0 ? -1 : selectedMenu == 2 ? 1 : 0)

                         
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(backgroundColor)
                                .frame(width: iconWidth, height: proxy.size.height)
                                .offset(x: leadingOffset - 10)
                                .blur(radius: 7)
                                .animation(.easeInOut(duration: 0.3), value: selectedMenu)
                                .opacity(0.5)
                                .onTapGesture {
                                    withAnimation {
                                        self.selectedMenu = 2
                                    }
                                }
                        }
                    )
                    .frame(maxWidth: .infinity)
                        .padding(.horizontal, 30)
       
                }
                .offset(y: -10)
            }
        }
        .padding(.horizontal, 50)
    }
    
    private func getModifiedColor(_ color: Color) -> Color {
        let teal = Color.teal
        let green = Color.green
        let yellow = Color.yellow
        let orange = Color.orange
        let red = Color.red
        
        switch sliderProgress {
        case 0..<0.125:
            return blendColors(teal, green, fraction: sliderProgress / 0.125)
        case 0.125..<0.25:
            return blendColors(green, yellow, fraction: (sliderProgress - 0.125) / 0.125)
        case 0.25..<0.5:
            return blendColors(yellow, orange, fraction: (sliderProgress - 0.25) / 0.25)
        case 0.5..<0.75:
            return blendColors(orange, red, fraction: (sliderProgress - 0.5) / 0.25)
        case 0.75...1:
            return red
        default:
            return color
        }
    }
    
    private func blendColors(_ color1: Color, _ color2: Color, fraction: Double) -> Color {
        let cgColor1 = color1.cgColor
        let cgColor2 = color2.cgColor
        
        guard let components1 = cgColor1?.components, let components2 = cgColor2?.components else {
            return color1
        }
        
        let red = components1[0] * (1 - fraction) + components2[0] * fraction
        let green = components1[1] * (1 - fraction) + components2[1] * fraction
        let blue = components1[2] * (1 - fraction) + components2[2] * fraction
        let alpha = components1[3] * (1 - fraction) + components2[3] * fraction
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
    }
    
    func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct WaterWaveShape: Shape {
    
    let frequency: CGFloat = 3 //频率
    
    var progress: CGFloat
    // Wave Height
    var waveHeight: CGFloat
    var offset: CGFloat
    
    var animatableData: CGFloat{
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            // Start from the top-left corner
            path.move(to: CGPoint(x: 0, y: 0))
            
            // Calculate wave height based on the progress
            let progressWidth: CGFloat = progress * rect.width
            let height = waveHeight * rect.width
            
            // Draw waves from top to bottom
            for value in stride(from: 0, through: rect.width, by: 1) {
                let y: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value*frequency + offset).radians)
                let x: CGFloat = progressWidth + (height * sine)
                path.addLine(to: CGPoint(x: x, y: y))
            }
            // Close the path to the bottom-right and bottom-left corners
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.closeSubpath()
        }
    }
}

struct MenuButton: View {
    var label: String
    var isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .center, content:{
            Text(label)
                //.foregroundColor(isSelected ? .blue : .gray)
                .frame(width: 48, height: 48)
            Rectangle()
                .fill(Color(hex: "#BFC7D7").opacity(isSelected ? 0.0 : 1.0))
                .frame(width: 52, height: 430, alignment: .bottom)
                
        })
        .mask(Text(label).frame(width: 48, height: 48))
        .frame(width: 48, height: 48)
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        
    }
}



#Preview {
    Tube()
}
