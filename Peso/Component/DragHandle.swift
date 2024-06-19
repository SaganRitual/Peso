// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension Component {
    
    final class DragHandle: SKShapeNode {
        static let radius = 25.0

        static func makeShape() -> DragHandle {
            let shape = DragHandle(circleOfRadius: radius)

            shape.lineWidth = 1
            shape.strokeColor = .green
            shape.fillColor = .clear
            shape.blendMode = .replace
            shape.isHidden = true
            shape.name = "MoveHandleShape"

            return shape
        }
    }

}
