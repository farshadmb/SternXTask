# SternXTask

The Application was written in a Swift 5.9. The App represent Posts API and Generating Report. Application contains the three layers which are the `Data Layer`, `Domain Layer` or `Business Layer` and `Presentation Layer` in MVVM.

## Requirements

- Xcode 15.0 or laster.
- Swift 5.9 or later.
- iOS 16.0 or later.

## Installation

- Step 1: Install Bundler via Running the below command

  ```Bash
  gem install bundler --user-install
  ```

- Step 2: Install Cocoapods via

  ```Bash
  gem install cocoapods --user-install
  ```

- Step 3: run command below in terminal.

  ```zsh
   pods install
   ```

- Step 3: Open `SternXTask.xcworspace` file.
- Step 4: Run and enjoy the app.

## Run Test Cases

You could run the test case with two methods that brought below:

*Methods:*

- Run Unit Test Cases via Xcode Unit test section.
- Run Unit Test Cases via terminal by using fastlane and bundle
  
  1. Install bundler by entering the command line. `$ gem install bundler`
  2. then Enter `$ bundle install`.
  3. Run `$ bundle exec fastlane runTestCases` command.

## Technology use in this project

- Reactive Functional Programming
- RxSwift
- Clean Code
- Clean Arch [Reference](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- Modern MVVM
- CI Testing
