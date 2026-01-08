# Kix Sneaker Store (A SwiftUI Test Application)

**This is a test application, created specifically for practicing and demonstrating UI and Unit testing in a SwiftUI environment.**

Kix is a sample e-commerce app for a modern sneaker store. Its primary purpose is to serve as a realistic, hands-on project for writing, running, and maintaining a comprehensive test suite using XCTest. The entire architecture and UI are designed with testability as the top priority.

![Kix App Screenshot](https://raw.githubusercontent.com/byKosta/Kix-app/main/kix-promo.png) 
*(Feel free to replace this with your own screenshot)*

---

## 🎯 Project Purpose

The main goal of this application is to serve as a practical example for:
*   **UI & Unit Testing:** The app is built from the ground up with testability in mind, featuring accessibility identifiers for all interactive elements.
*   **SwiftUI Implementation:** Demonstrates modern SwiftUI patterns for navigation, state management, and building a component-based UI.
*   **Clean Architecture:** Showcases a clean, scalable, and maintainable project structure (MVVM).

---

## ✨ Features

*   **Full Authentication Flow:** Mock user login and registration screens.
*   **Tab-Based Navigation:** A `TabView` provides access to the main sections of the app:
    *   **Home:** A scrollable list of sneaker products.
    *   **Favorites:** A view to manage the user's favorite items.
    *   **Cart:** A functional shopping cart to add and manage products.
    *   **Notes:** A simple CRUD section for practicing unit tests.
    *   **Menu:** A section for user profile and app settings.
*   **Interactive UI:** Smooth animations and visual feedback on user interactions.
*   **Mock Data Layer:** The app uses a mock data service, ensuring there are no network dependencies. This makes testing fast, reliable, and predictable.

---

## 🛠️ Tech Stack & Architecture

*   **Framework:** SwiftUI
*   **Language:** Swift
*   **Testing:** XCTest for both UI and Unit Tests.
*   **Architecture:** The project follows the **Model-View-ViewModel (MVVM)** pattern. The code is organized into distinct layers for clarity and separation of concerns:
    *   `App`: The main entry point.
    *   `Core`: Shared components, models, and theme (colors, typography).
    *   `Features`: Individual screens of the app (e.g., Auth, Home, Cart).
    *   `Navigation`: Manages the app's main navigation flow (e.g., TabView).
    *   `Services`: Provides data to the app (e.g., MockDataService).

---

## 🚀 Getting Started

### Prerequisites
*   Xcode 15.0 or later
*   iOS 16.0 or later

### How to Run the App
1.  Clone the repository:
    ```sh
    git clone https://github.com/byKosta/Kix-app.git
    ```
2.  Open the `Kix.xcodeproj` file in Xcode.
3.  Select a simulator (e.g., iPhone 15 Pro) and press the "Run" button (or `Cmd + R`).

### How to Run Tests
1.  Open the Test Navigator in Xcode (or press `Cmd + 6`).
2.  Click the play button next to the `KixUITests` or `KixTests` target to run all tests.
3.  You can also run individual test cases by clicking the play button next to a specific test function.
