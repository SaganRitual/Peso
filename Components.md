#  Components of SKPlayground

## Selection Marquee

Draws a rectangle on the scene when the user drags the mouse across the scene background.
When the user ends the drag operation by releasing the mouse, a selection operation is
performed on the game entities within the rectangle.

The selection marquee needs access to the following components:

- The scene, in order to draw the visible selection marquee
- The selection controller, in order to trigger the selection operation

## Selection Controller

Manages the selected/non-selected state of the game entities. 

The selection controller needs access to the following components:

- The game, in order to access the individual game entities to select/deselect them

## Game

Manages the set of game entities, creating and deleting them per user inputs

The game needs acces to the following components:

- The scene, in order to trigger creation of entity view sprites

## Scene

Creates and deletes the sprites that represent game entities. Receives and dispatches
mouse input

# Operations

1. Create game entity on mouse click
    1. Create entity view for the entity
    1. Select new entity
    1. Update entity view to show a visible selection indicator
    
1. Select/deselect entity on mouse click or on selection with marquee
1. Move sprite and update entity internally in response to user dragging the sprite with the mouse
1. Scale and/or rotate sprite and update entity internally in response to user dragging special handles on selection indicator

# Entities And Components

1. Entity View
    Some game entities have a visual representation in the GameScene. In some cases this representation
    will be an SKSpriteNode, and in others an SKShapeNode
1. Selectability
    Some game entities are selectable. The selection state is a boolean value in the entity, and will be
    represented visually by an SKShapeNode in the form of a ring that appears around the entity's view
1. Draggability
    Some selectable game entities are draggable: a draggable entity's selection node will receive mouse
    up/down/drag inputs and will move itself and its underlying entity
1. Roscalability
    "Roscale" means rotate and/or scale. Some selectable game entities are roscalable. A roscalable entity's
    selection node will have an additional four SKShapeNodes attached as children at the cardinal points
    along the perimeter of the selection ring. Dragging any one of these sub-handles will rotate and/or
    scale the underlying entity with the mouse movement
1. Physics
    Some entities may have an associated SKPhysicsBody
1. Gremlin
    The primary game entity, represented visually by a cartoonish cyclops sprite in the GameScene. All Gremlins are selectable,
    draggable, and roscalable. All Gremlins also have an associated SKPhysicsBody
1. Waypoint
    Another game entity, represented visually by a flagpole sprite in the GameScene. Waypoints are selectable and draggable
