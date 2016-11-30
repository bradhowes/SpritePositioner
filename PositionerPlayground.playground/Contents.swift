import PlaygroundSupport
import SpriteKit

// The size of the sprite we will position
//
let spriteSize = CGSize(width: 10, height: 15)

// The size of the board we will position on
//
let rect = CGRect(x:0 , y:0, width: 477, height: 311)

// A region where we do not want to have any sprites.
//
let void = CGRect(x: rect.midX - 40, y: rect.midY - 40, width: 80, height: 80)

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
scene.backgroundColor = UIColor.darkGray

// Show the scene
//
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

// Create a button that will (re)generate positions
//
let frame = CGRect(x: sceneView.frame.midX - 30, y: sceneView.frame.midY - 13, width: 60, height: 26)
let button = RegenButton(frame: frame, scene: scene, pos: pos, spriteSize: spriteSize, void: void)
sceneView.addSubview(button)
button.regenPositions()

print("xSpacing: \(pos.xSpacing) xVar: \(pos.xVar) ySpacing: \(pos.ySpacing) yVar: \(pos.yVar)")
