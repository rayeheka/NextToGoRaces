# NextToGoRaces

This project is an iOS application that displays upcoming races with detailed summaries, countdown timers, and customizable views. The app is built using Swift, with MVVM architecture, and contains various iOS design patterns like Coordinator and Dependency Injection.

## Features

- **Upcoming Races Display**: View a list of the next races to go, including meeting name and race number of each race.
- **Filter Races**: Filter shown races based on selected categories, helping user filter races to the desired ones.
- **Real-Time Countdown**: Live countdowns to each race start time, ensuring a smooth user experience.
- **API Integration**: Fetches race data from a backend service, including race summaries and next-to-go race IDs.

## Architecture

This project is built using the **MVVM** architecture, which promotes a clean separation of concerns:

- **Model**: Defines the data structure and handles data-related logic.
- **View**: The UI components.
- **ViewModel**: Manages the state and business logic, interacting with the Model and updating the View.
- **Coordinator Pattern**: Manages navigation and flow between view controllers.
- **Dependency Injection**: Injects dependencies like network services into view models and other classes.

## Unit Testing

Unit tests are implemented for various components.

These tests cover:
- Data fetching and parsing.
- Race sorting and filtering.

## Contact
This project is developed by Rayeheh Karimanipour for a purpose of technical task.
ka.rayehe@gmail.com
