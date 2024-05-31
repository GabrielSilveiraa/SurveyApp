# SurveyApp

SurveyApp is a SwiftUI application designed to provide an interactive survey experience. Users can navigate through various survey questions, submit their answers, and receive immediate feedback. The app is built using the Composable Architecture to ensure a modular, testable, and maintainable codebase.

## Table of Contents

- [Description](#description)
- [Architecture](#architecture)
- [Packages](#packages)
- [Setup](#setup)
- [Running the App](#running-the-app)
- [Tests](#tests)
- [Demo](#demo)
- [Contributing](#contributing)
- [License](#license)

## Description

SurveyApp aims to provide a seamless and engaging survey experience. Users can:

- Load and view multiple survey questions.
- Submit answers and receive immediate feedback.
- Navigate through questions easily.
- Handle errors gracefully with informative banners.

## Architecture

SurveyApp is built using the Composable Architecture (TCA), which promotes a clear separation of concerns and ensures the app is both scalable and maintainable. Key components include:

- **Views**: SwiftUI views that render the user interface.
- **State**: Centralized state management using TCA's `Store` and `Reducer`.
- **Actions**: Define the events that can happen in the app.
- **Reducers**: Pure functions that describe how the state should change in response to actions.
- **Effects**: Asynchronous work, such as network requests, handled in a testable way.

## Packages

SurveyApp integrates several packages to enhance its functionality:

- [Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture): For state management.
- [Quick](https://github.com/Quick/Quick) and [Nimble](https://github.com/Quick/Nimble): For behavior-driven testing.
- [GMSNetworkLayer](https://github.com/GabrielSilveiraa/GMSNetworkLayer): A network layer package that simplifies making network requests and handling responses in Swift.
- [swiftui-preview-snapshots](https://github.com/doordash-oss/swiftui-preview-snapshots): A tool that allows for easy snapshot testing of SwiftUI views.

## Setup

To set up the project on your local machine, follow these steps:

1. **Clone the repository**:
    ```sh
    git clone https://github.com/GabrielSilveiraa/SurveyApp.git
    cd SurveyApp
    ```

2. **Install dependencies**:
    Open the project in Xcode and ensure that Swift Package Manager resolves all dependencies.

3. **Open the project**:
    Open `SurveyApp.xcodeproj` in Xcode.

## Running the App

To run the app:

1. Select the target device or simulator in Xcode.
2. Press `Cmd + R` or click the Run button in Xcode.

## Tests

SurveyApp includes unit tests to ensure the reliability of the app's core functionality. The tests are written using Quick and Nimble in a behavior-driven development (BDD) style.

To run the tests:

1. Select the `SurveyApp` target in Xcode.
2. Press `Cmd + U` or go to `Product > Test`.

### Snapshot Tests
In addition to unit tests, SurveyApp includes snapshot tests for SwiftUI views using the [swiftui-preview-snapshots](https://github.com/doordash-oss/swiftui-preview-snapshots) package. Snapshot tests help ensure the visual correctness of your views by comparing the current appearance of a view with a previously recorded snapshot.

To run the tests:

You will see that the snapshot tests are disabled due to some issues with the CI's runner version available (xcode and macos). I would have to invest more time to investigate the issue and fix it.
So just change `xit` to `it` in the snapshot test file to be able to run it.

## Demo
Here is a demo of SurveyApp in action:

![SurveyApp Demo](https://github.com/GabrielSilveiraa/SurveyApp/assets/7571525/700f81b1-bcff-4f13-a355-e40a9857fead)

## Contributing
Contributions to SurveyApp are welcome. If you would like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes.
4. Ensure all tests pass and add new tests if needed.
5. Submit a pull request with a detailed description of your changes.

## License
SurveyApp is released under the MIT License. See [LICENSE](LICENSE) for details.
