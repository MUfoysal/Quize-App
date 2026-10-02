# Quiz App

A Flutter-based multiple-choice quiz application focused on programming and computer science knowledge.

The project is built with Flutter and Firebase Firestore and follows Clean Architecture to keep the presentation, business logic, and data layers separated.

## Features

* Multiple-choice programming and computer science questions
* Questions loaded from Firebase Firestore
* Single-answer selection
* Correct and incorrect answer feedback
* Question progress indicator
* Live score tracking
* Final score and percentage
* Correct and wrong answer count
* Quiz restart
* Back to Home navigation
* Loading state
* Error handling with retry option
* Responsive Flutter UI

## Screenshots

### Home Screen

![Home Screen](screenshots/home.png)

### Correct Answer

![Correct Answer](screenshots/rightAnswer.png)

### Wrong Answer

![Wrong Answer](screenshots/wrongAnswer.png)

### Result Screen

![Result Screen](screenshots/result.png)

## Technologies

* Flutter
* Dart
* Firebase Core
* Cloud Firestore
* Git
* GitHub

## Architecture

This project follows Clean Architecture with three main layers:

### Presentation Layer

Responsible for displaying the UI and handling user interaction.

```text
presentation/
├── screens/
└── widgets/
```

### Domain Layer

Contains the core business logic and application contracts.

```text
domain/
├── entities/
├── repositories/
└── usecases/
```

### Data Layer

Responsible for retrieving data from Firebase and converting it into domain entities.

```text
data/
├── datasources/
├── models/
├── repositories/
└── di/
```

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── quiz/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── result/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── firebase_options.dart
└── main.dart
```

## Quiz Data Flow

Questions are loaded through the following flow:

```text
Firebase Firestore
        ↓
QuizRemoteDataSource
        ↓
QuestionModel
        ↓
QuizRepositoryImpl
        ↓
Question Entity
        ↓
GetQuestions Use Case
        ↓
QuizScreen
```

This keeps the QuizScreen independent from Firebase implementation details.

## Firestore Structure

Quiz questions are stored inside the `questions` collection.

Each question document contains:

```text
question              String
options               Array<String>
correctAnswerIndex    Integer
```

Example:

```text
questions/
└── q1
    ├── question: "What does OOP stand for?"
    ├── options:
    │   ├── "Object-Oriented Programming"
    │   ├── "Object Operating Program"
    │   ├── "Operational Object Programming"
    │   └── "Object Order Protocol"
    └── correctAnswerIndex: 0
```

`correctAnswerIndex` uses a zero-based index:

```text
0 → A
1 → B
2 → C
3 → D
```

## How It Works

1. The application initializes Firebase.
2. The user opens the Quiz screen.
3. The `GetQuestions` use case requests the quiz questions.
4. The repository retrieves the data through the remote data source.
5. Firestore returns the question documents.
6. `QuestionModel.fromMap()` converts Firestore data into a model.
7. `toEntity()` converts the model into a domain entity.
8. The QuizScreen displays the questions.
9. The user selects an answer.
10. The selected answer is checked against `correctAnswerIndex`.
11. The score is updated when the selected answer is correct.
12. The user continues through the questions.
13. After the final question, the ResultScreen displays the score, percentage, correct answers, and wrong answers.
14. The user can restart the quiz or return to the home screen.

## Firebase Security

The `questions` collection is configured for read access while client-side writes are disabled.

The current setup is suitable for this portfolio project. A production quiz application could move answer validation to a trusted backend so that correct answers are not exposed directly to the client.

## Getting Started

### Prerequisites

Make sure Flutter and Dart are installed.

Current development environment:

```text
Flutter 3.47.5
Dart 3.13.4
```

A Firebase project configured with FlutterFire is also required.

### Installation

Clone the repository:

```bash
git clone https://github.com/MUfoysal/Quize-App.git
```

Navigate to the project:

```bash
cd Quize-App
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Firebase Configuration

Firebase is initialized in `main.dart`.

FlutterFire generates the platform-specific Firebase configuration in:

```text
lib/firebase_options.dart
```

The application uses:

```yaml
firebase_core
cloud_firestore
```

## Future Improvements

Possible future improvements include:

* Quiz categories
* Difficulty levels
* Question randomization
* Timer-based quizzes
* Detailed result analysis
* Local quiz history
* User authentication
* Leaderboard
* Admin question management
* Server-side answer validation

## Project Purpose

This project was developed as a practical Flutter portfolio project to demonstrate:

* Flutter UI development
* Dart programming
* Clean Architecture
* Repository Pattern
* Use Case based design
* Firebase integration
* Cloud Firestore
* Asynchronous programming
* State management
* Navigation
* Git and GitHub workflow

## Author

**Mohib Ullah Foysal**

Computer Science & Technology Student
Flutter & App Development

GitHub: [MUfoysal](https://github.com/MUfoysal)

## License

This project is created for educational and portfolio purposes.
