// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
 
class GameScene: SKScene {
    var gameController: GameController!
    let selectionMarquee: SelectionMarquee

    let cameraNode = SKCameraNode()
    let entitiesNode = SKNode()

    var dragAnchor: CGPoint?
    var isDragging = false

    init(_ selectionMarquee: SelectionMarquee) {
        self.selectionMarquee = selectionMarquee
        super.init(size: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // If we set the scene size in init(), we'll get that size on the first run
    // of the app, (or if we delete the app data and run again). It doesn't seem to
    // matter that we set the scaleMode in didMove(to view); the scene still won't
    // resize until the user actually drags the window to be a different size.
    // Some update happens in that user resizing that doesn't happen on just running
    // the app. By sheer brute-force trial and error, I've found that setting the
    // scale mode in this function cause the scene to resize itself without any
    // help from the user.
    //
    // Still, as of 2024.0512, the scene continues to report an incorrect node count
    // and incorrect frame rate until some sort of user activity occurs. Haven't
    // figured that one out yet
    override func didChangeSize(_ oldSize: CGSize) {
        scaleMode = .resizeFill
    }

    override func didMove(to view: SKView) {
        isUserInteractionEnabled = true

        scaleMode = .resizeFill
        backgroundColor = .black

        physicsWorld.gravity = .zero
        physicsWorld.speed = 0

        addChild(cameraNode)
        camera = cameraNode

        cameraNode.position = gameController.gameSettings.cameraPosition
        cameraNode.setScale(gameController.gameSettings.cameraScale)

        addChild(entitiesNode)
        addChild(selectionMarquee.marqueeRootNode)
    }

    override func mouseDown(with event: NSEvent) {
        dragAnchor = event.location(in: self)
    }

    override func mouseDragged(with event: NSEvent) {
        isDragging = true
        let location = event.location(in: self)
        selectionMarquee.draw(from: dragAnchor!, to: location)
        gameController.gameSettings.mousePosition = location
    }

    override func mouseMoved(with event: NSEvent) {
        let location = event.location(in: self)
        gameController.gameSettings.mousePosition = location
    }

    override func mouseUp(with event: NSEvent) {
        let location = event.location(in: self)
        let control = event.modifierFlags.contains(.control)
        let shift = event.modifierFlags.contains(.shift)

        if isDragging {

            // End of a drag operation
            isDragging = false

            let dragAnchor = self.dragAnchor!
            let rectangle = makeRectangle(vertexA: dragAnchor, vertexB: location)

            if shift {
                gameController.toggleSelect(in: rectangle)
            } else {
                gameController.deselectAll()
                gameController.select(in: rectangle)
            }

        } else {

            if control {
                // Show context menu
            } else {
                // Plain left-click
                let gremlin = gameController.newGremlin(at: location)

                gameController.deselectAll()
                gameController.select(gremlin)
            }

        }

        selectionMarquee.hide()
        dragAnchor = nil
        isDragging = false
    }
}

private extension GameScene {

    func makeRectangle(vertexA: CGPoint, vertexB: CGPoint) -> CGRect {
        let LL = CGPoint(x: min(vertexA.x, vertexB.x), y: min(vertexA.y, vertexB.y))
        let UR = CGPoint(x: max(vertexA.x, vertexB.x), y: max(vertexA.y, vertexB.y))

        let size = CGSize(width: UR.x - LL.x, height: UR.y - LL.y)

        return CGRect(origin: LL, size: size)
    }

}
