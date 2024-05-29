//
//  ContentView.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 29/5/24.
//

import SwiftUI
import PreviewSnapshots

struct ContentView: View {
    @ScaledMetric(relativeTo: .headline) var buttonCornerRadius = 10

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Button(action: {
                    // TODO: Show next screen
                }) {
                    Text(LocalizationKey.welcomeCtaTitle)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(asset: Asset.primary))
                        .cornerRadius(buttonCornerRadius)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                Spacer()
            }
            .background(Color(.systemGray6))
            .navigationBarTitle(LocalizationKey.welcomeTitle, displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }

    static var snapshots: PreviewSnapshots<PreviewConfiguration> {
        PreviewSnapshots(
            configurations: [
                .init(name: "Base Welcome View", state: .init()),
                .init(name: "Dark Welcome View", state: .init(colorScheme: .dark)),
                .init(name: "xxxLarge Welcome View", state: .init(dynamicTypeSize: .accessibility5)),
            ],
            configure: { state in
                ContentView()
                    .environment(\.colorScheme, state.colorScheme)
                    .environment(\.dynamicTypeSize, state.dynamicTypeSize)
            }
        )
    }
}
