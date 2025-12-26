# habits24

A Flutter application for tracking and managing daily habits. This app helps users build positive routines by tracking their daily activities and providing insights into their progress over time.

## Features

- Habit creation and customization
- Daily habit tracking with check-off functionality
- Progress visualization and statistics
- Goal setting and reminders
- Data persistence across app sessions
- Clean and intuitive user interface

## Architecture

The application follows a clean architecture pattern with separation of concerns:

### Presentation Layer
- **UI Components**: Stateless and stateful widgets for the user interface
- **State Management**: Uses Provider pattern for state management
- **Screens**: Organized in separate files under the `screens` directory

### Domain Layer
- **Entities**: Core business models and entities
- **Use Cases**: Business logic and operations
- **Repositories**: Abstract interfaces for data operations

### Data Layer
- **Data Sources**: Local database (using Hive/SharedPreferences) and potential remote APIs
- **Models**: Data models for API responses and local storage
- **Repositories Implementation**: Concrete implementations of domain repositories

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
├── screens/                  # UI screens
├── widgets/                  # Reusable UI components
├── services/                 # Business logic services
├── providers/                # State management providers
└── utils/                    # Utility functions and constants
```

## Getting Started

This project is a Flutter application. Before running the application, ensure you have Flutter installed on your system. If you haven't already, follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install).

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE with Flutter support (Android Studio, VS Code, etc.)

### Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
   cd habits24
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

### Development

For development, you can use hot reload to see changes in real-time:
1. Run the application
2. Make changes to the code
3. Press `r` in the terminal where the app is running to reload

## Technologies Used

- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language for Flutter
- **Provider**: State management solution
- **Hive**: Lightweight NoSQL database for local storage
- **Flutter Icons**: Material icons and Cupertino icons

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
