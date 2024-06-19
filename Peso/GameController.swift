// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GameController: ObservableObject {
    let gameScene: GameScene
    let gameSettings: GameSettings

    var entities = [Entity<SelectionHalo>]()

    init(gameSettings: GameSettings) {
        let selectionMarquee = SelectionMarquee(gameSettings)
        let gameScene = GameScene(selectionMarquee)

        self.gameSettings = gameSettings
        self.gameScene = gameScene
        self.gameScene.gameController = self
    }

    func newGremlin(at position: CGPoint) -> Gremlin {
        let gremlinView = EntityViewSprite(imageNamed: "cyclops")
        let gremlin = Gremlin(gremlinView)

        gameScene.entitiesNode.addChild(gremlinView)

        gremlinView.setOwnerEntity(gremlin)

        return gremlin
    }
}

extension GameController {
    func deselect(_ entity: Entity<SelectionHalo>) {
        entity.selectionHalo.hide()
    }

    func deselectAll() {
        entities.forEach { $0.selectionHalo.hide() }
    }

    func select(_ entity: Entity<SelectionHalo>) {
        entity.selectionHalo.show()
    }

    func select(in rectangle: CGRect) {
        getSelectable(in: rectangle)?.forEach { $0.selectionHalo.show() }
    }

    func toggleSelect(_ entity: Entity<SelectionHalo>) {
        entity.selectionHalo.toggleVisible()
    }

    func toggleSelect(in rectangle: CGRect) {
        getSelectable(in: rectangle)?.forEach { $0.selectionHalo.toggleVisible() }
    }
}

private extension GameController {

    func getSelectable(in rectangle: CGRect) -> [Entity<SelectionHalo>]? {
        let entities: [Entity<SelectionHalo>] = self.entities.compactMap { entity in
            guard rectangle.contains(entity.selectionHalo.node.position) else {
                return nil
            }

            return entity
        }

        return entities.isEmpty ? nil : entities
    }

}
