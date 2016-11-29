import PlaygroundSupport
import SpriteKit

// The size of the sprite we will position
//
let spriteSize = CGSize(width: 10, height: 15)

// The size of the board we will position on
//
let rect = CGRect(x:0 , y:0, width: 477, height: 311)

// Create the positioner. We pass in the board frame to allow positions on all of it.
// We allow a sprite to randomly vary over half of its dimensions, so worst-case is that
// we need a separation of one sprite unit without any collisions.
//
let randomSource = RandomUniform()
let pos = Positioner(bounds: rect,
                     minSeparation: spriteSize,
                     minVariance: spriteSize / 2.0,
                     randomSource: randomSource)

// Create the SpriteKit scene view and scene to show the results
//
let sceneView = SKView(frame: rect)
let scene = SKScene(size: rect.size)

// Show the scene
//
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

// Create an event responder for the (i) button in the upper-left corner. Touching it will
// Regenerate positions and the nodes in the scene.
//
class Responder : NSObject {
    func action() {
        scene.removeAllChildren()
        pos.generate()
        print("\(pos.xSpacing) \(pos.xVar) \(pos.ySpacing) \(pos.yVar)")

        // Show a sprite for each position.
        //
        var index = 0
        for pt in pos {

            // Create a color that fades down to 0.10 alpha
            //
            let color = UIColor(colorLiteralRed: 0.0,
                                green: 1.0,
                                blue: 1.0,
                                alpha: 1.0 - (Float(index) / Float(pos.count) * 0.90))

            // Create sprite with the above color at the position from the Positioner
            //
            let node = SKSpriteNode(color: color, size: spriteSize)
            index += 1
            node.position = pt
            scene.addChild(node)
        }
    }
}

// Create a button and respond to its touches
//
let responder = Responder()
responder.action()
let button = UIButton(type: .infoLight)
button.addTarget(responder, action: #selector(Responder.action), for: .touchUpInside)
sceneView.addSubview(button)

// *FIXME*
//
let margins = sceneView.layoutMarginsGuide
button.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10.0).isActive = true
button.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10.0).isActive = true
sceneView.setNeedsLayout()
