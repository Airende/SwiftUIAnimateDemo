//
//  ZYAnimateText.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/12.
//

import SwiftUI
import AnimateText

struct ZYAnimateText: View {
    let words = "Labyrinth,Ineffable,Incendiary,Ephemeral,Cynosure,Propinquity,Infatuation,Incandescent,Eudaemonia,Raconteur,Petrichor,Sumptuous,Aesthete,Nadir,Miraculous,Lassitude,Gossamer,Bungalow,Aurora,Inure,Mellifluous,Euphoria,Cherish,Demure,Elixir,Eternity,Felicity,Languor,Love,Solitude,Epiphany,Quintessential,Plethora,Nemesis,Lithe,Tranquility,Elegance,Renaissance,Eloquence,Sequoia,Peace,Lullaby,Paradox,Pristine,Effervescent,Opulence,Ethereal,Sanguine,Panacea,Bodacious,Axiom,Silhouette,Surreptitious,Ingenue,Dulcet,Tryst,Ebullience".components(separatedBy: ",")
    let sentence = "Don’t dwell on the past.,Believe in yourself.,Follow your heart.,Seize the day.,You only live once.,Past is just past.,Love yourself.,Don’t beat yourself up.,Life is a journey.,No Pain,No gain,No sweat,The die is cast.,When they go low,A friend is a second myself.,Appearances are deceptive.,Be brave.,Every cloud has a silver lining.,Don’t judge a book by its cover.,Hang in there.,This is how life is.,Live positive.,Seeing is believing.,He can do, She can do,Why not me,If not now,then when?,Respect individual.,Habit is a second nature.,Time is gold.,You deserve to be loved.,Love what you do.,Time waits for no one.,Don’t waste your youth.,Pain past is pleasure.,United we stand.,Envy and wrath shorten life.,Life is all about timing.".components(separatedBy: ",")
    
    let customUserInfo: [String : Any] = ["color": Color.accentColor]
    let typeUserInfo: [String : Any] = ["base": "-"]
    
    @State private var unitType: ATUnitType = .letters
    
    var content: some View {
        Group {
            Group {
                TapAnimateTextView<CustomEffect>(type: unitType, elements: getElements(), userInfo: customUserInfo)
            }
            Group {
                TapAnimateTextView<ATRandomTypoEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATTypoEffect>(type: unitType, elements: getElements(), userInfo: typeUserInfo)
                TapAnimateTextView<ATPaperEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATChainEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATChimeBellEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATCurtainEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATDropEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATHangEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATSpringEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATTwistEffect>(type: unitType, elements: getElements())
            }
            Group {
                TapAnimateTextView<ATOpacityEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATRotateEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATBlurEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATBottomTopEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATTopBottomEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATOffsetEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATScaleEffect>(type: unitType, elements: getElements())
                TapAnimateTextView<ATSlideEffect>(type: unitType, elements: getElements())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $unitType, content: {
                    Text("Letters").tag(ATUnitType.letters)
                    Text("Words").tag(ATUnitType.words)
                }, label: {
                    EmptyView()
                })
                    .pickerStyle(.segmented)
                    .padding()
                TabView {
                    content
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
            .navigationTitle(Text("AnimateText"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
    
    private func getElements() -> [String] {
        return self.unitType == .letters ? self.words : self.sentence
    }
}

fileprivate
struct CustomEffect: ATTextAnimateEffect {
    
    var data: ATElementData
    var userInfo: Any?
    
    var color: Color = .red
    
    public init(_ data: ATElementData, _ userInfo: Any? = nil) {
        self.data = data
        self.userInfo = userInfo
        if let info = userInfo as? [String: Any] {
            color = info["color"] as! Color
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(data.value)
            content
                .foregroundColor(color)
                .opacity(data.invValue)
                .overlay {
                    Rectangle()
                        .fill(Color.clear)
                        .border(Color.accentColor.opacity(0.5), width: 1)
                }
        }
        .animation(.spring(response: 1.2, dampingFraction: 0.6, blendDuration: 0.9).delay(Double(data.index)*0.1),value: data.value)
        .scaleEffect(data.scale, anchor: .bottom)
        .rotationEffect(.degrees(-360 * data.invValue))
        .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.9).delay(Double(data.index)*0.1), value: data.value)
    }
    
}


fileprivate
struct TapAnimateTextView<E: ATTextAnimateEffect>: View {
    
    let type: ATUnitType
    let elements: [String]
    var userInfo: Any? = nil
    
    @State private var text: String = ""
    
    var body: some View {
        GeometryReader { proxy in
            VStack (alignment: .leading, content: {
                Spacer()
                ZStack (alignment: .leading, content: {
                    AnimateText<E>($text,type: type, userInfo: userInfo)
                        .font(.custom("Helvetica SemiBold", size: 30))
                        .padding(.vertical)
                    if text.isEmpty {
                        VStack (alignment: .leading, content: {
                            Text(String(describing: E.self))
                                .foregroundStyle(Color.accentColor)
                                .font(.custom("Helvetica SemiBold", size: 30))
                                .transition(.opacity)
                            Text("Touch the screen.")
                                .font(.callout)
                                .opacity(0.3)
                                .disabled(true)
                        })
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.24), value: text)
                    }
                })
                .padding()
                .padding(.bottom, 50)
                .animation(.easeIn, value: text)
                Spacer()
            })
        }
        .clipped()
        .contentShape(Rectangle())
        .onTapGesture {
            self.changeText()
        }
        .onAppear{
            text = ""
        }
    }
    
    private func changeText(){
        let newText = self.elements[Int.random(in: (0..<self.elements.count))]
        if Bool.random() == true {
            text = newText
        }else {
            text = newText.uppercased()
        }
    }
}


#Preview {
    ZYAnimateText()
}
