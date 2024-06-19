// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SelectionHalo {
    weak var entity: Entity<SelectionHalo>?
    let node: SKShapeNode

    required init(entity: Entity<SelectionHalo>) {
        self.entity = entity
        self.node = SKShapeNode()
    }

    func hide() { node.isHidden = true }
    func show() { node.isHidden = false }
    func toggleVisible() { node.isHidden = !node.isHidden }
}

class SelectionHaloDraggable: SelectionHalo {
}

class SelectionHaloRoscalable: SelectionHaloDraggable {
}

