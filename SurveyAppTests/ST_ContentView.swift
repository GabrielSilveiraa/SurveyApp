import PreviewSnapshotsTesting
import Quick
@testable import SurveyApp

final class ST_ContentView: QuickSpec {
    override static func spec() {
        describe("\(ContentView.self) Spec") {
            context("For Snapshot Configurations") {
                it("Generated one should mactch with the recorded") {
                    ContentView_Previews.snapshots.assertSnapshots()
                }
            }
        }
    }
}
