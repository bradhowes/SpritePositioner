import UIKit
import SpriteKit

// Create an event responder for the button in the upper-left corner. Touching it will
// Regenerate positions and the nodes in the scene.
//
public final class RegenButton : UIButton {

    public var scene: SKScene!
    public var pos: Positioner!
    private let spriteSize: CGSize!
    private let void: CGRect

    public init(frame: CGRect, scene: SKScene, pos: Positioner, spriteSize: CGSize, void: CGRect) {
        self.scene = scene
        self.pos = pos
        self.spriteSize = spriteSize
        self.void = void
        super.init(frame: frame)

        contentHorizontalAlignment = .center
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setTitle("Regen", for: .normal)
        setTitleColor(UIColor.green, for: .normal)
        addTarget(self, action: #selector(self.regenPositions), for: .touchUpInside)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func regenPositions() {
        self.scene.removeAllChildren()

        // Add rect node to show where the void is. Make semi-transparent to show that there are no nodes hiding 
        // underneath
        //
        let v = SKSpriteNode(color: UIColor.red.withAlphaComponent(0.25), size: void.size)
        v.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        scene.addChild(v)

        // Generate new positions, filtered so that no sprite rectangles faill into the void.
        //
        self.pos.generate {
            let r = CGRect(origin: $0, size: self.spriteSize).offsetBy(dx: self.spriteSize.width / -2.0,
                                                                       dy: self.spriteSize.height / -2.0)

            return !(self.void.intersects(r)) //  || self.void.contains(r))
        }

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
