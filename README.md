# TSU.MAD.iOS-2025.Lab1
## Movie Catalog — Emotion Tracker

A laboratory project developed as part of the mobile development course. The application is designed for tracking user emotions using UIKit and the MVVM-C architecture.

---

## Core Functionality

- Animated background on the login screen:
  - Four circular gradients smoothly moving across the screen using Core Animation.
- Emotion Journal:
  - Slowly rotating activity indicator when there are no entries for the day.
  - Dynamic visualization of daily goal completion (2+ entries per day).
  - Multi-colored circle fill based on the colors of the user's emotions.
- Emotion Adding Screen:
  - Emotion selection through horizontal scrolling and tapping.
  - Automatic selection of the emotion positioned at the center of the screen.
- Customized TimePicker component.
- Emotion visualization via tables and graphs with gradient fills and animations.
- Face ID support for user authentication.

---

## Architecture and Technologies

- UIKit
- MVVM-C (Model-View-ViewModel-Coordinator)
- Core Data (local database management)
- Core Animation (gradient animations)
- LocalAuthentication (Face ID)
- Auto Layout (adaptive layout)
- Custom UI components

---

## Implementation Details

- Local data storage is implemented using Core Data.
- Coordinators manage navigation between screens.
- Graphs and tables are built using UIKit without third-party libraries.
- All animations are created with native iOS tools.
- Minimal usage of third-party dependencies in the project.
