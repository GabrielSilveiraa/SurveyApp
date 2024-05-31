import PreviewSnapshotsTesting
import Quick
@testable import SurveyApp

final class ST_SurveyView: QuickSpec {
    override static func spec() {
        describe("\(SurveyView.self) Spec") {
            context("For Snapshot Configurations") {
                xit("Generated one should mactch with the recorded") {
                    SurveyView_Previews.snapshots.assertSnapshots()
                }
            }
        }
    }
}
