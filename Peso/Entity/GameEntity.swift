// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class Entity<HaloType: SelectionHalo> {
    private(set) var selectionHalo: HaloType!

    func replaceSelectionHalo<T: SelectionHalo>(with newHaloType: T.Type) {
        selectionHalo = newHaloType.init(entity: self)
    }
}
