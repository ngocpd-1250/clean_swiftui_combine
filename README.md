# Clean Architecture using SwiftUI + Combine

This is a boilerplate project for iOS applications built using the Clean Architecture approach with SwiftUI and Combine.

## Features

- **Clean Architecture**: Separation of concerns with clear boundaries between layers.
- **SwiftUI**: Declarative UI framework for building modern iOS apps.
- **Combine**: Reactive framework for handling asynchronous events and data streams.
- **Dependency Injection**: Easy management of dependencies and testability.
- **Modularization**: Encourages modular design for better code organization and reusability.
- **Unit Tests**: Includes unit tests for business logic and use cases.
- **Dark Mode**: Programmatically supports Dark Mode switch.
- **SwiftData**: SwiftData support.


## Requirements

- Xcode 15.0+
- Swift 5.7+
- [Homebrew](https://brew.sh/) installed

## Installation

1. **Install Homebrew Dependencies**:

    ```bash
    brew install xcodegen swiftlint swiftformat
    ```

2. **Clone the Repository**:

    ```bash
    git clone git@github.com:ngocpd-1250/clean_swiftui_combine.git
    cd BaseSwiftUI
    ```

3. **Generate Xcode Project**:

    Use `xcodegen` to generate the Xcode project:

    ```bash
    xcodegen
    ```

4. **Open Xcode**:

    Open the generated Xcode project:

    ```bash
    open BaseSwiftUI.xcodeproj
    ```

5. **Build and Run**:

    Build and run the project in Xcode.

## Project Structure

The project follows the Clean Architecture principles with the following layers:

- **Presentation**: SwiftUI views, navigators and view models.
- **Domain**: Business logic and use cases.
- **Data**: Data sources and repositories.

## Linting

1. **Linting**: [SwiftLint](https://github.com/realm/SwiftLint)
2. **Formatting**: [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)

## Packages

1. [LinkNavigator](https://github.com/interactord/LinkNavigator.git): for navigation management
2. [Factory](https://github.com/hmlongco/Factory.git): for dependency injection
3. [Rswift](https://github.com/mac-cain13/R.swift.git): for resource management
4. [Kingfisher](https://github.com/onevcat/Kingfisher.git): for loading and caching remote images
5. [Alamofire](https://github.com/Alamofire/Alamofire.git): for API requests
