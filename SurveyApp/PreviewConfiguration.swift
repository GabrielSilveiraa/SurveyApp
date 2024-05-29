import SwiftUI

struct PreviewConfiguration {
    let colorScheme: ColorScheme
    let dynamicTypeSize: DynamicTypeSize

    init(colorScheme: ColorScheme = .light,
         dynamicTypeSize: DynamicTypeSize = .large) {
        self.colorScheme = colorScheme
        self.dynamicTypeSize = dynamicTypeSize
    }
}
