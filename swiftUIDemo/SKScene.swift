//
//  SKScene.swift
//  swiftUIDemo
//
//  Created by 聪少 on 2024/8/6.
//

import SwiftUI
import SpriteKit

struct MySKScene: View {
    @State private var dx: Double = 0
    @State private var dy: Double = -10
    @State private var isOpen: Bool = false
    @State private var isActive: Bool = false
    @Binding var isClear: Bool
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack {
                    if !isActive {
                        SpriteView(scene: getScene(proxy.size))
                    }
                }
                if !isClear {
                    FabulaSlider(value: $dx, title: "X", min: -20, max: 20) { value in
                        isActive = value
                    }
                    FabulaSlider(value: $dy, title: "Y", min: -20, max: 20) { value in
                        isActive = value
                    }
                }
            }
        }
    }
    
    private func getScene(_ size: CGSize) -> GameScene {
        let scene = GameScene()
        scene.size = size
        scene.scaleMode = .fill
        scene.backgroundColor = .black
        scene.physicsWorld.gravity = .init(dx: dx, dy: dy)
        return scene
    }
    
}
fileprivate
class CircleNode: SKShapeNode {
    var screenSize: CGSize!
    var circleSize: CGFloat = 40
    
    override init() {
        super.init()
    }
    
    convenience init(screenSize: CGSize, count: Int) {
        self.init()
        self.init(circleOfRadius: circleSize)
        self.screenSize = screenSize
        
        self.fillColor = Bool.random() ? SKColor.red : SKColor.blue
        self.strokeColor = SKColor.brown
        self.physicsBody = SKPhysicsBody(circleOfRadius: circleSize)
        self.lineWidth = 2
        
        let countLabel = SKLabelNode(fontNamed: "Helvetica Bold")
        countLabel.text = "\(count)"
        countLabel.fontSize = 28
        countLabel.fontColor = .white
        countLabel.horizontalAlignmentMode = .center
        countLabel.verticalAlignmentMode = .center
        self.addChild(countLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GameScene: SKScene {
    private var count: Int = 0
    private var previousTranslateX: CGFloat = 0.0
    
    override func didMove(to view: SKView) {
        view.showsFPS = true
        view.showsNodeCount = true
        view.showsPhysics = false
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        self.createBox(location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        print("touchesMoved : ", location)
    }
    
    
    func createBox(_ location: CGPoint){
        count += 1
        let box = CircleNode(screenSize: self.size, count: count)
        box.position = location
        addChild(box)
    }
}

struct FabulaSlider: View {
    @Binding var value: Double
    var title: String = ""
    var min: CGFloat = 0
    var max: CGFloat = 100
    var onEditingChanged: (Bool)->() = {_ in}
    
    var body: some View {
        HStack {
            Text(title)
            ZStack {
                HStack {
                    ZStack {
                        Slider(value: $value, in: min...max) { value in
                            onEditingChanged(value)
                        }
                    }
                    Text("\(String(format: "%.1f", value))")
                        .font(.body)
                }
            }
        }
    }
}


#Preview {
    MySKScene(isClear: .constant(false))
}
