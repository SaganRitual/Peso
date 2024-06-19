// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class Gremlin: GameEntity {
    var view: EntityViewSprite!

    func postInit(view: EntityViewSprite, selectionHalo: SelectionHalo) {
        self.view = view
        self.selectionHalo = selectionHalo
    }

    static func make(at position: CGPoint) -> Gremlin {
        let gremlinView = EntityViewSprite(imageNamed: "cyclops")
        let gremlin = Gremlin()
        let selectionHalo = SelectionHalo.makeHalo()

        gremlin.postInit(view: gremlinView, selectionHalo: selectionHalo)
        selectionHalo.postInit(gremlin)
        gremlinView.postInit(gremlin, position)

        return gremlin
    }
}

