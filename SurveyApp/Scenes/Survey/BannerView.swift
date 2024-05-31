//
//  BannerView.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 30/5/24.
//

import SwiftUI

enum BannerType: Equatable {
    case success
    case error
}

struct BannerView: View {
    var type: BannerType
    var retryAction: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(type == .success ? LocalizationKey.surveyBannerSuccessTitle : LocalizationKey.surveyBannerErrorTitle)
                .font(.headline)
                .foregroundColor(.white)
            if type == .error,
               let retryAction = retryAction {
                Spacer()
                Button(action: retryAction) {
                    Text(LocalizationKey.surveyBannerErrorRetryCta)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(type == .success ? .green : .red)
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView(type: .success)
    }
}
