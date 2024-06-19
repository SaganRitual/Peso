// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GameController: ObservableObject {
    let gameScene: GameScene
    let gameSettings: GameSettings

    var entities = [GameEntity]()

    init(gameSettings: GameSettings) {
        let selectionMarquee = SelectionMarquee(gameSettings)
        let gameScene = GameScene(selectionMarquee)

        self.gameSettings = gameSettings
        self.gameScene = gameScene
        self.gameScene.gameController = self
    }

    func newGremlin(at position: CGPoint) -> Gremlin {
        let gremlin = Gremlin.make(at: position)

        gameScene.entitiesNode.addChild(gremlin.view)

        return gremlin
    }
}

extension GameController {
    func deselect(_ entity: GameEntity) {
        entity.selectionHalo.hide()
    }

    func deselectAll() {
        entities.forEach { $0.selectionHalo.hide() }
    }

    func select(_ entity: GameEntity) {
        entity.selectionHalo.show()
    }

    func select(in rectangle: CGRect) {
        getSelectable(in: rectangle)?.forEach { $0.selectionHalo.show() }
    }

    func toggleSelect(_ entity: GameEntity) {
        entity.selectionHalo.toggleVisible()
    }

    func toggleSelect(in rectangle: CGRect) {
        getSelectable(in: rectangle)?.forEach { $0.selectionHalo.toggleVisible() }
    }
}

private extension GameController {

    func getSelectable(in rectangle: CGRect) -> [GameEntity]? {
        let entities: [GameEntity] = self.entities.compactMap { entity in
            guard rectangle.contains(entity.selectionHalo.position) else {
                return nil
            }

            return entity
        }

        return entities.isEmpty ? nil : entities
    }

}
