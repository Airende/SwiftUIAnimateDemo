//
//  TextFloatView.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/20.
//

//import PlaygroundSupport
import SwiftUI

struct PureGeniusView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill()
        .foregroundColor(.init(hue: 0.57, saturation: 0.25, brightness: 1))
      Circle()
        .frame(width: 320, height: 320)
        .foregroundColor(.init(hue: 0.8, saturation: 0.25, brightness: 0.75))
      VStack {
        PGWordView(word: ["竹", "叶", "专", "注"]).offset(x: 0, y: 40)
        PGWordView(word: ["G", "E", "N", "I", "U", "S"]).offset(x: 0, y: -40)
      }
    }
  }
}

struct PGWordView: View {
  var word: [String]
  var body: some View {
    HStack {
        ForEach(word, id: \.self) { letter in
            PGLetterView(text: letter)
        }
    }
  }
}

struct PGLetterView: View {
  var text: String
  var body: some View {
    ZStack {
      MovingLetterView(text: text, color: .init(hue: 0.14, saturation: 0.56, brightness: 0.98))
      MovingLetterView(text: text, color: .init(hue: 0.37, saturation: 0.52, brightness: 0.7))
    }
  }
}

struct MovingLetterView: View {
  var text: String
  var color: Color
  
  @State var position: CGPoint = .zero
  @State var activeTimer: Timer? = nil
  
  private let animationDuration: Double = 2
  private let maxOffset: CGFloat = 10
  private var timer: Timer {
    return Timer.scheduledTimer(withTimeInterval: self.animationDuration * 0.25, repeats: true) {_ in
      let x = CGFloat(arc4random_uniform(UInt32(self.maxOffset))) - (self.maxOffset / 2)
      let y = CGFloat(arc4random_uniform(UInt32(self.maxOffset))) - (self.maxOffset / 2)
      self.position = CGPoint.init(x: x, y: y)
    }
  }
  
  var body: some View {
    Text(text)
      .foregroundStyle(self.color)
      .font(Font.custom("Baskerville-Bold", size: 40))
      .bold()
      .offset(x: self.position.x, y: self.position.y)
      .animation(.easeInOut(duration: self.animationDuration), value: self.position)
      .onAppear {
        self.activeTimer = self.timer
    }
      .onDisappear {
        self.activeTimer = nil
    }
  }
}

#Preview {
    PureGeniusView()
}
