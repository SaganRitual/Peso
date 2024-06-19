// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SelectionHalo: SKShapeNode {
    weak var gameEntity: GameEntity?

    static let radius = 25.0

    static func makeHalo() -> SelectionHalo {
        let shape = SelectionHalo(circleOfRadius: radius)

        shape.lineWidth = 1
        shape.strokeColor = .green
        shape.fillColor = .clear
        shape.blendMode = .replace
        shape.isHidden = true
        shape.name = "MoveHandleShape"

        return shape
    }

    func postInit(_ gameEntity: GameEntity) {
        self.gameEntity = gameEntity
    }
}

class SelectionHaloDraggable: SelectionHalo {
}

class SelectionHaloRoscalable: SelectionHaloDraggable {
}

