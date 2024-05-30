//
//  SurveyView.swift
//  SurveyApp
//
//  Created by Gabriel Miranda on 29/5/24.
//

import SwiftUI
import ComposableArchitecture
import PreviewSnapshots

struct SurveyView: View {
    let store: StoreOf<SurveyReducer>
    @ScaledMetric(relativeTo: .subheadline) var questonsSubmittedTextHeight = 50
    @ScaledMetric(relativeTo: .headline) var cornerRadius = 10
    @ScaledMetric var textEditoHeight = 150

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                ZStack(alignment: .top) {
                    VStack {
                        if viewStore.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(2)
                                .padding(.top, 40)
                                .frame(maxWidth: .infinity)
                        } else {
                            Text(LocalizationKey.surveyTitle(viewStore.questionsSubmitted))
                                .font(.subheadline)
                                .bold()
                                .frame(height: questonsSubmittedTextHeight)
                                .frame(maxWidth: .infinity)
                                .background(Color(asset: Asset.main))
                                .padding(.top, 10)

                            if let currentQuestion = viewStore.currentQuestion {
                                Text(currentQuestion.text)
                                    .font(.title)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)
                                    .padding(.top, 40)

                                ZStack {
                                    if currentQuestion.answer.isEmpty {
                                        TextEditor(text: .constant(LocalizationKey.surveyPlaceholder))
                                            .scrollContentBackground(.hidden)
                                            .frame(height: textEditoHeight)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(cornerRadius)
                                            .opacity(0.5)
                                    }
                                    TextEditor(text: viewStore.binding(
                                        get: { _ in currentQuestion.answer },
                                        send: SurveyReducer.Action.updateAnswer
                                    ))
                                    .scrollContentBackground(.hidden)
                                    .frame(height: textEditoHeight)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(cornerRadius)
                                    .opacity(currentQuestion.answer.isEmpty ? 0.25 : 1)
                                    .disabled(currentQuestion.isSubmitted)
                                }
                                .padding(.leading, 10)

                                Button(action: {
                                    viewStore.send(.submitAnswer)
                                }) {
                                    Text(currentQuestion.isSubmitted ? LocalizationKey.surveyCtaDisabled : LocalizationKey.surveyCta)
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(asset: Asset.main))
                                        .cornerRadius(cornerRadius)
                                        .shadow(radius: currentQuestion.isSubmitted ? 0 : 5)
                                }
                                .padding(.horizontal, 40)
                                .padding(.top, 20)
                                .disabled(currentQuestion.isSubmitted)
                                .opacity(currentQuestion.isSubmitted ? 0.30 : 1)

                            } else {
                                Text(LocalizationKey.surveyErrorNoQuestions)
                            }
                            Spacer()
                        }
                    }

                    if case let .show(bannerType) = viewStore.bannerPresentation {
                        BannerView(type: bannerType, retryAction: {
                            let _ = withAnimation {
                                viewStore.send(.retrySubmission)
                            }
                        })
                        .onTapGesture(perform: {
                            let _ = withAnimation {
                                viewStore.send(.hideBanner)
                            }
                        })
                    }
                }
                .task {
                    viewStore.send(.loadQuestions)
                }
                .navigationBarTitle(LocalizationKey.surveyNavigationTitle(viewStore.questionNumber, viewStore.totalQuestions), displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        HStack {
                            Button(action: {
                                viewStore.send(.previousQuestion)
                            }) {
                                Text(LocalizationKey.surveyNavigationPreviousTitle)
                            }
                            .disabled(viewStore.questionNumber == 1)

                            Button(action: {
                                viewStore.send(.nextQuestion)
                            }) {
                                Text(LocalizationKey.surveyNavigationNextTitle)
                            }
                            .disabled(viewStore.questionNumber == viewStore.totalQuestions)
                        }
                )
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .background(Color(.systemGray6))
        }
    }
}


extension SurveyView {
    static func buildDefault() -> Self {
        .init(store: Store(initialState: SurveyReducer.State(), reducer: SurveyReducer.buildDefault))
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
}
