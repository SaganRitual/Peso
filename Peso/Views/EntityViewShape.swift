// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class EntityViewShape: SKShapeNode {
    override func mouseDown(with event: NSEvent) {
        print("shape mouse down")
    }

    override func mouseUp(with event: NSEvent) {
        print("shape mouse up")
    }
}
