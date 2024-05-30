import SwiftUI

struct PreviewConfiguration<State> {
    let colorScheme: ColorScheme
    let dynamicTypeSize: DynamicTypeSize
    let state: State?

    init(colorScheme: ColorScheme = .light,
         dynamicTypeSize: DynamicTypeSize = .large,
         state: State? = nil) {
        self.colorScheme = colorScheme
        self.dynamicTypeSize = dynamicTypeSize
        self.state = state
    }
}
