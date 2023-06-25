# NYTimes

The Popular News iOS App is a sample application that fetches popular news articles using the [NYTimes](https://www.nytimes.com) API. It is built using the MVVM (Model-View-ViewModel) design pattern and incorporates dependency injection for improved modularity and testability.

## Features

- Fetches and displays a list of popular news articles from the [NYTimes](https://www.nytimes.com) API.
- Displays the title, abstract, section, byline, and published date for each news article.
- Allows users to view the full news article by tapping on a specific item.

## Architecture

The app follows the MVVM architecture pattern, which separates the concerns of data manipulation (Model), UI presentation (View), and business logic (ViewModel). Here's an overview of the architecture:

<p align="center">
  <img src ="https://github.com/Sajjad-Zafar/NYTimes/blob/main/MVVM.png?raw=true"/>
</p>

- Model: Represents the data entities used in the app, such as NewsModel and NewsResults.
- View: Displays the UI components and interacts with the user. It includes the NewsListingViewController, which is responsible for presenting the list of news articles.
- ViewModel: Acts as the intermediary between the View and Model layers. The NewsListingViewModel handles the business logic and data manipulation for the news listing screen. It interacts with the NetworkService for fetching news data and the ImageLoaderService for loading news images.
- Dependency Injection: The app utilizes dependency injection to provide instances of the required services (e.g., NetworkService and ImageLoaderService) to the ViewModels. This promotes modularity, testability, and flexibility in swapping out implementations.

## Testing

The app includes unit tests to ensure the correctness of its components and features. The tests can be run using Fastlane, which provides automation for building, testing, and deploying iOS apps. Fastlane actions can be used to execute the unit tests and generate test reports.

### Prerequisites
Before running the unit tests using Fastlane, make sure you have the following:

- Xcode installed on your machine.
- Fastlane installed globally on your machine.

### Running Unit Tests with Fastlane
To run the unit tests and generate test reports using Fastlane, follow these steps:

1. Open a terminal and navigate to the root directory of the Popular News iOS App project.
2. Run the following command to execute the unit tests:

```
fastlane run_test
```
This command will build the app, run the unit tests, and generate test reports.

3. Once the tests are completed, you can find the test reports in the fastlane folder of your project. The reports include detailed information about the test results and any failures or errors encountered during testing.

```
/fastlane/code_covrage/report.html
```
Open the test reports in your preferred browser to view the results and analyze the test coverage.

## Environment

- Swift 5
- iOS 14+
- XCode 14.3.1

## Dependencies

The app relies on the following dependencies:

- Combine: Used for handling asynchronous operations and data streams.
- UIKit: Provides the UI components and framework for building the iOS app.
- Foundation: Provides essential classes and protocols for the app's functionality.

## Installation

To run the NYTimes iOS App on your device or simulator:

- Clone the repository.
- Open the Xcode project file NYTimes.xcodeproj.
- Build and run the project using the selected target device or simulator.

## Demo
<p align="left">
  <img src ="https://github.com/Sajjad-Zafar/NYTimes/blob/main/demo.png?raw=true" alt="demo" width=300px/>
</p>

## Contributing

Contributions are welcome 🎉🎊

When contributing to this repository, please first discuss the change you wish to make via issue before making a change.

You can also opening a PR if you want to fix bugs or improve something.
