// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class EntityViewSprite: SKSpriteNode {
    var dragAnchor: CGPoint?
    var dragging = false

    func postInit(_ gameEntity: GameEntity, _ position: CGPoint) {
        self.position = position
        setOwnerEntity(gameEntity)
    }

    override func mouseDown(with event: NSEvent) {
        // Remember to treat the next mouse move as begin-drag
        if getOwnerEntity()?.selectionHalo is SelectionHaloDraggable {
            dragAnchor = position
        }
    }

    override func mouseDragged(with event: NSEvent) {
        let mousePositionInScene = event.location(in: scene!)

        if let dragAnchor = self.dragAnchor {
            // The user has just now begun a mouse-drag; wait for the snap distance
            // before we allow the sprite to be moved; after that it can move freely
            if dragAnchor.distance(to: mousePositionInScene) > 5 {
                self.dragAnchor = nil   // Finished with setup; now just move with the mouse
            }
        }

        position = mousePositionInScene
    }

    override func mouseUp(with event: NSEvent) {
        dragAnchor = nil

        let mousePositionInScene = event.location(in: scene!)

        if dragging {
            dragging = false
            position = mousePositionInScene
            return
        }

        if let halo = getOwnerEntity()?.selectionHalo as? SelectionHaloDraggable {
            if event.modifierFlags.contains(.control) {
                // Context menu for this entity
            } else if event.modifierFlags.contains(.shift) {
                halo.toggleVisible()
            } else {
                halo.show()
            }
        }
    }

}
