# NextToGoRaces

This project is an iOS application that displays upcoming races with detailed summaries, countdown timers, and customizable views. The app is built using Swift, with MVVM architecture, and contains various iOS design patterns like Coordinator and Dependency Injection.

**EDIT**: The app's UI layer is now updated to SwiftUI.

## Features

- **Upcoming Races Display**: View a list of the next races to go, including meeting name and race number of each race.
- **Filter Races**: Filter shown races based on selected categories, helping user filter races to the desired ones.
- **Real-Time Countdown**: Live countdowns to each race start time, ensuring a smooth user experience.
- **API Integration**: Fetches race data from a backend service, including race summaries and next-to-go race IDs.
- **Scalable Layout**: Provides scalable layout so that by changing accessibility on text size and bold, UI updates.

## Architecture

This project is built using the **MVVM** architecture, which promotes a clean separation of concerns:

- **Model**: Defines the data structure and handles data-related logic.
- **View**: The UI components.
- **ViewModel**: Manages the state and business logic, interacting with the Model and updating the View.
- **Dependency Injection**: Injects dependencies like network services into view models and other classes.
- **Coordinator Pattern**: Manages navigation and flow between view controllers.

**EDIT**: Coordinator Pattern is removed in the new version as we are now using SwiftUI which has a native approach for managing view hierarchy and navigation.

## Additional Improvements
- **Custom Decodable**: Custom decodable is written for decoding Races Summary.

## Unit Testing

Unit tests are implemented for various components with a code coverage of 88%.

These tests cover:
- Data fetching and parsing.
- Race sorting and filtering logic.

## Contact
This project is developed by Rayeheh Karimanipour for a purpose of technical task.
ka.rayehe@gmail.com
