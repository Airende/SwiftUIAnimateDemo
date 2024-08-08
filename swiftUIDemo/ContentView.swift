import SwiftUI
import CoreMotion

struct ContentView: View {
    
    let colors = [Color(hex: 0x1D427B), Color(hex: 0x285D99), Color(hex: 0x3476BA), Color(hex: 0x4091DA), Color(hex: 0x54A7E2), Color(hex: 0x71BDEB), Color(hex: 0x91D3F3), Color(hex: 0xB5E8FC)]
    @StateObject var motionManager: MotionManager = MotionManager()

    var body: some View {
        
//        Text("一段文字")
//            .modifier(Motion2DModifier(manager: motionManager, magnitude: 60*0.2))
//            .shadow(color: .black, radius: 3, x: motionManager.pitch*(10), y: motionManager.roll*(-5))
        
        GeometryReader { proxy in
            ZStack {
                ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                    RoundedRectangle(cornerSize: CGSize(width: 45, height: 45))
                        .fill(color)
                        .frame(width: proxy.size.width-CGFloat(index)*5, height: proxy.size.height-CGFloat(index)*10)
                        .modifier(Motion2DModifier(manager: motionManager, magnitude: 60.0*CGFloat(index)*0.1))
                }
            }
            .backgroundStyle(Color.black)
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 1)
        }
        
        .ignoresSafeArea()
    }
}

extension ContentView {
    struct Motion2DModifier: ViewModifier {
        @ObservedObject var manager: MotionManager
        var magnitude: Double = 30
        
        func body(content: Content) -> some View {
            content
                .offset(CGSize(width: CGFloat(manager.roll*magnitude), height: CGFloat(manager.roll*magnitude)))
        }
        
    }
    
    class MotionManager: ObservableObject {
        @Published var pitch: Double = 0.0
        @Published var roll: Double = 0
        
        var interval: CGFloat = 0.01
        private var manager: CMMotionManager
        
        init(){
            self.manager = CMMotionManager()
            self.manager.deviceMotionUpdateInterval = interval
            self.manager.startDeviceMotionUpdates(to: .main) { motionData, error in
                guard error == nil, let motionData = motionData else { return }
                
                withAnimation {
                    self.pitch = motionData.attitude.pitch
                    self.roll = motionData.attitude.roll
                }
                
            }
        }
        
    }
    
}

struct SampleMenuAndCommands_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}

public extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
