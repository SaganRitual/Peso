// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class Gremlin: Entity<SelectionHaloRoscalable> {
    let view: EntityViewSprite

    init(_ view: EntityViewSprite) {
        self.view = view

        super.init()

        replaceSelectionHalo(with: SelectionHaloRoscalable.self)
    }
}

