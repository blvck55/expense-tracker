# Expense Tracker

A cross-platform personal finance management application built with Flutter and Firebase. The application enables users to securely manage income and expenses, organize transactions, attach receipts, analyze spending patterns, and customize their experience through multi-currency and light/dark theme support.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Tools Used](#tools-used)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Application Flow](#application-flow)
- [Firebase Integration](#firebase-integration)
- [Data Model](#data-model)
- [State Management](#state-management)
- [UI and UX](#ui-and-ux)
- [Getting Started](#getting-started)
- [Firebase Configuration](#firebase-configuration)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Supported Platforms](#supported-platforms)
- [Security](#security)
- [Screenshots](#screenshots)
- [Future Improvements](#future-improvements)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## Overview

Expense Tracker is a personal finance management application designed to simplify the process of recording, monitoring, and analyzing financial activity.

The application provides users with a centralized platform for managing income and expenses while providing visual insights into their spending patterns.

The application uses Firebase Authentication for user authentication and Cloud Firestore for cloud-based data storage and synchronization.

### Objectives

- Provide a simple interface for recording income and expenses.
- Allow users to manage financial transactions through CRUD operations.
- Provide visual representations of spending and income.
- Keep user financial data isolated and securely associated with individual accounts.
- Support multiple currencies.
- Provide light and dark theme customization.
- Maintain a modular and maintainable application architecture.
- Provide cross-platform support through Flutter.

---

# Features

## User Authentication

The application uses Firebase Authentication to provide secure account management.

Features include:

- User registration
- User login
- Authentication state management
- Automatic authentication routing
- Session management
- User logout
- User-specific data access

The application uses an authentication wrapper to determine whether the user should be directed to the authentication interface or the main application.

---

## Income and Expense Management

Users can manage financial transactions through full CRUD functionality.

Supported operations:

- Create transactions
- View transactions
- Update transactions
- Delete transactions

Each transaction can contain:

- Amount
- Transaction type
- Category
- Date
- Payment method
- Notes
- Receipt image
- Timestamp
- User ID

The application supports both income and expense transactions.

---

## Transaction Categories

Transactions can be assigned to predefined categories.

### Expense Categories

- Food
- Transport
- Bills
- Shopping
- Entertainment
- Health

### Income Categories

- Salary
- Investment

Categories are used throughout the application for transaction organization and financial analytics.

---

## Receipt Attachments

Users can attach receipt or bill images to individual transactions.

The application supports:

- Capturing images using the device camera
- Selecting images from the device gallery
- Previewing selected images
- Associating receipt images with transactions

Image selection and camera/gallery access are handled using the `image_picker` package.

---

## Financial Dashboard

The home dashboard provides an overview of the user's financial activity.

The dashboard includes:

- Current net balance
- Total income
- Total expenses
- Recent transactions
- Spending overview
- Financial summary information

The dashboard is designed to provide users with a quick understanding of their current financial position.

Example:

```text
Net Balance
LKR 125,450.00

Total Income
LKR 185,000.00

Total Expenses
LKR 59,550.00
```

---

## Financial Analytics

The application provides graphical financial analytics using the `fl_chart` package.

Analytics include:

- Spending distribution
- Category-based spending
- Income versus expenses
- Spending trends
- Transaction summaries

Charts are generated from the user's transaction data.

---

## Statistics

The Statistics screen provides a dedicated view for analyzing financial activity.

Users can view:

- Spending distribution by category
- Income versus expense comparisons
- Total income
- Total expenses
- Net balance
- Transaction counts
- Category spending information

Example category breakdown:

```text
Food              32%
Bills             20%
Transport         18%
Shopping          15%
Entertainment     10%
Other              5%
```

---

## Multi-Currency Support

The application supports dynamic currency selection.

Users can select their preferred currency from the settings interface.

Supported currencies can include:

- LKR — Sri Lankan Rupee
- USD — United States Dollar
- EUR — Euro
- GBP — British Pound
- INR — Indian Rupee
- AUD — Australian Dollar

Currency formatting is handled using the `intl` package.

The selected currency is applied throughout the application's financial interface.

---

## Theme Customization

The application supports both light and dark themes using Material 3.

Available theme modes:

- Light
- Dark
- System Default

### Light Theme

| Purpose | Colour |
|---|---|
| Primary | `#10B981` |
| Primary Dark | `#059669` |
| Background | `#F8FAFC` |
| Surface | `#FFFFFF` |
| Primary Text | `#0F172A` |
| Secondary Text | `#64748B` |
| Border | `#E2E8F0` |
| Income | `#22C55E` |
| Expense | `#EF4444` |
| Warning | `#F59E0B` |

### Dark Theme

| Purpose | Colour |
|---|---|
| Background | `#0F172A` |
| Surface | `#1E293B` |
| Primary | `#34D399` |
| Primary Text | `#F8FAFC` |
| Secondary Text | `#94A3B8` |
| Border | `#334155` |
| Income | `#4ADE80` |
| Expense | `#F87171` |

---

## Profile and Settings

The settings section allows users to manage their account and application preferences.

Features include:

- View profile information
- Manage account preferences
- Select preferred currency
- Change application theme
- Sign out

---

# Technology Stack

| Category | Technology |
|---|---|
| Framework | Flutter |
| Programming Language | Dart |
| UI Framework | Material 3 |
| State Management | Provider |
| Authentication | Firebase Authentication |
| Database | Cloud Firestore |
| Charts | fl_chart |
| Image Handling | image_picker |
| Date and Currency Formatting | intl |
| Backend Services | Firebase |
| Platforms | Android, iOS, Web |

---

# Tools Used

## Main Development Tools

| Tool / Technology | Purpose & Description |
|---|---|
| **Flutter SDK** | Cross-platform framework for building native Android, iOS, and Web user interfaces |
| **Dart SDK** | Primary object-oriented programming language for Flutter application development |
| **Android Studio / VS Code** | Integrated Development Environments (IDEs) used for coding, debugging, and emulator management |
| **Firebase Console** | Backend cloud service platform for managing Authentication and Cloud Firestore DB |
| **FlutterFire CLI** | Command-line interface for configuring Firebase services across platforms |
| **Git & GitHub** | Distributed version control system and repository hosting for source code management |
| **Gradle** | Build automation tool used for compiling and packaging the Android application |
| **flutter_launcher_icons** | Automated tool for generating custom application launcher icons across platforms |

## AI Tools Used

| AI Tool | Usage & Application |
|---|---|
| **ChatGPT / Claude / AI Assistant** | Assisted with software architecture planning, UI/UX layout recommendations, code refactoring, bug troubleshooting, and documentation generation |
| **GitHub Copilot / Android Studio AI** | Provided intelligent code completions, boilerplate code generation, and syntax suggestions during development |

---

# Architecture

The application follows a layered architecture that separates the user interface, application state, business logic, external services, and data models.

```text
Presentation Layer
        |
        v
State Management
        |
        v
Services Layer
        |
        v
Firebase
        |
        v
Cloud Firestore
```

This separation improves maintainability, testability, and scalability.

---

## Presentation Layer

The presentation layer contains the screens and reusable UI components.

```text
screens/
widgets/
```

Responsibilities include:

- Rendering application screens
- Handling user interaction
- Displaying financial information
- Displaying charts
- Managing forms
- Displaying loading and error states

---

## State Management Layer

The application uses Provider for state management.

```text
providers/
```

### AuthProvider

Responsible for:

- Authentication state
- Current user
- Login status
- Logout operations

### ExpenseProvider

Responsible for:

- Loading transactions
- Adding transactions
- Updating transactions
- Deleting transactions
- Maintaining transaction state
- Calculating financial summaries

### ThemeProvider

Responsible for:

- Light theme
- Dark theme
- System theme
- Theme switching

### CurrencyProvider

Responsible for:

- Selected currency
- Currency changes
- Currency formatting

---

## Services Layer

```text
services/
```

The services layer separates external services and application operations from the user interface.

### AuthService

Handles Firebase Authentication operations including:

- User registration
- User login
- User logout
- Authentication state

### FirestoreService

Handles Cloud Firestore operations including:

- Creating transactions
- Reading transactions
- Updating transactions
- Deleting transactions
- Retrieving user-specific transactions

---

# Project Structure

```text
lib/
|
├── app/
│   ├── app_colors.dart
│   └── app_theme.dart
│
├── models/
│   └── expense_model.dart
│
├── providers/
│   ├── auth_provider.dart
│   ├── expense_provider.dart
│   ├── theme_provider.dart
│   └── currency_provider.dart
│
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
│
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   │
│   ├── expense/
│   │   └── add_edit_expense_dialog.dart
│   │
│   ├── home/
│   │   └── home_screen.dart
│   │
│   ├── settings/
│   │   └── settings_profile_screen.dart
│   │
│   ├── stats/
│   │   └── stats_screen.dart
│   │
│   └── widgets/
│       ├── expense_card.dart
│       ├── summary_card.dart
│       └── empty_state.dart
│
└── main.dart
```

---

# Application Flow

The main authentication flow is:

```text
Application Launch
        |
        v
Firebase Authentication
        |
        +----------------------+
        |                      |
        v                      v
   Logged Out              Logged In
        |                      |
        v                      v
Login / Register           Home Screen
```

After authentication, users can navigate between the primary areas of the application.

```text
Home
 |
 +---- Transactions
 |
 +---- Statistics
 |
 +---- Settings
 |
 +---- Add Transaction
```

---

# Transaction Flow

The transaction management process follows this structure:

```text
User
 |
 v
Add / Edit Transaction
 |
 v
ExpenseProvider
 |
 v
FirestoreService
 |
 v
Cloud Firestore
 |
 v
Updated Transaction Data
 |
 v
ExpenseProvider
 |
 v
Updated UI
```

This structure separates UI interaction from database operations.

---

# Firebase Integration

The application uses Firebase as its cloud backend.

## Firebase Services

```text
Firebase Core
Firebase Authentication
Cloud Firestore
```

### Firebase Authentication

Firebase Authentication is responsible for:

- User registration
- User login
- Authentication state
- User sessions
- Logout

### Cloud Firestore

Cloud Firestore is responsible for storing:

- User transactions
- Transaction metadata
- Categories
- Dates
- Amounts
- User identifiers
- Additional transaction information

---

# Data Isolation

Each transaction is associated with the authenticated user's unique Firebase user ID.

Conceptually:

```text
User
 |
 +-- userId
      |
      +-- Transaction
      +-- Transaction
      +-- Transaction
```

The application uses the authenticated user's ID to scope financial records to the appropriate account.

Firestore Security Rules should enforce this restriction at the database level.

---

# Data Model

The primary transaction model is:

```text
ExpenseModel
```

A transaction can contain the following fields:

```text
id
userId
amount
type
category
date
paymentMethod
note
imageUrl / imageReference
createdAt
```

The model provides Firestore mapping and `copyWith` functionality for creating updated instances.

---

# Authentication Architecture

The application uses an authentication wrapper to determine which interface should be displayed.

Conceptually:

```dart
AuthWrapper
    |
    +-- User authenticated
    |       |
    |       +-- HomeScreen
    |
    +-- User not authenticated
            |
            +-- LoginScreen / RegisterScreen
```

This prevents unauthenticated users from directly accessing the application's main financial dashboard.

---

# Dependencies

The primary dependencies include:

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core:
  firebase_auth:
  cloud_firestore:
  provider:
  fl_chart:
  image_picker:
  intl:
```

The exact dependency versions are maintained in `pubspec.yaml`.

---

# Getting Started

## Prerequisites

Install the following before setting up the project:

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Git
- A Firebase project

Verify the Flutter installation:

```bash
flutter doctor
```

---

# Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
```

Navigate to the project directory:

```bash
cd expense_tracker
```

Install dependencies:

```bash
flutter pub get
```

---

# Firebase Configuration

Create a Firebase project using the Firebase Console.

Enable the required Firebase services:

```text
Firebase Authentication
Cloud Firestore
```

Configure the authentication providers required by the application.

Install the FlutterFire CLI if it is not already installed:

```bash
dart pub global activate flutterfire_cli
```

Configure Firebase for the Flutter project:

```bash
flutterfire configure
```

This generates the platform-specific Firebase configuration required by the application.

---

# Running the Application

Run the application using:

```bash
flutter run
```

To view available devices:

```bash
flutter devices
```

Run the application on a specific device:

```bash
flutter run -d <device-id>
```

---

# Testing

Run automated Flutter tests:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

Format the Dart source code:

```bash
dart format .
```

---

# Supported Platforms

The application is designed using Flutter's cross-platform architecture and can target:

- Android
- iOS
- Web

Additional platform-specific configuration may be required for Firebase and camera/gallery functionality.

---

# Security

Security is an important consideration because the application handles personal financial information.

The application uses Firebase Authentication to identify users and associates transactions with authenticated user IDs.

Production Firestore Security Rules should restrict users to their own data.

A conceptual rule is:

```text
A user may access a transaction only when:

transaction.userId == request.auth.uid
```

Firebase credentials and other sensitive configuration values should not be hard-coded into application source code.

---

# UI and UX

The application follows a clean fintech-inspired design system.

### Design Principles

**Clarity**

Financial information should be understandable at a glance.

**Consistency**

Reusable components maintain consistent spacing, typography, colours, and interaction patterns.

**Visual Hierarchy**

Important information such as net balance, income, and expenses receives stronger visual emphasis.

**Accessibility**

The interface uses appropriate colour contrast and readable typography.

**Minimalism**

The interface focuses on essential financial information and actions without unnecessary visual elements.

**Responsiveness**

Layouts are designed to adapt to different screen sizes and platforms.

---

# Screenshots

Add screenshots of the application to this section.

Recommended screenshots include:

```text
screenshots/
|
├── login.png
├── register.png
├── dashboard.png
├── transactions.png
├── add_transaction.png
├── statistics.png
├── settings.png
└── dark_mode.png
```

Example:

```markdown
## Screenshots

### Login

![Login Screen](screenshots/login.png)

### Dashboard

![Dashboard](screenshots/dashboard.png)

### Transaction Management

![Transactions](screenshots/transactions.png)

### Statistics

![Statistics](screenshots/statistics.png)

### Settings

![Settings](screenshots/settings.png)
```

---

# Future Improvements

Potential future improvements include:

- Budget management
- Monthly and yearly spending limits
- Budget notifications
- Recurring transactions
- Savings goals
- CSV export
- PDF financial reports
- Advanced transaction filtering
- Multiple financial accounts
- Push notifications
- Receipt OCR
- Automatic transaction categorization
- Advanced financial analytics
- AI-powered spending insights
- Cloud Storage integration for receipt images
- Financial forecasting

---

# Project Development Practices

The project follows several development practices intended to improve maintainability:

- Separation of UI and business logic
- Provider-based state management
- Reusable widgets
- Service abstraction for Firebase operations
- Model-based data representation
- Centralized theme configuration
- Centralized application colours
- Modular project structure
- Firebase-backed data persistence

---

# Contributing

Contributions are welcome.

To contribute:

### 1. Fork the repository

```bash
git fork
```

### 2. Create a feature branch

```bash
git checkout -b feature/your-feature
```

### 3. Make your changes

Implement and test the required functionality.

### 4. Commit your changes

```bash
git commit -m "Add your feature"
```

### 5. Push the branch

```bash
git push origin feature/your-feature
```

### 6. Create a Pull Request

Provide a clear description of the changes and include screenshots where appropriate.

---

# Issue Reporting

If you encounter a bug, create a GitHub issue containing:

- Description of the issue
- Steps to reproduce
- Expected behaviour
- Actual behaviour
- Device and operating system
- Flutter version
- Relevant screenshots
- Error logs, if available

---

# License

This project is currently intended for educational and portfolio purposes.

A suitable open-source or proprietary license should be added before distributing the application publicly or commercially.

---

# Author

**Your Name**

Software Engineering Student / Developer

### Technical Skills Demonstrated

```text
Flutter
Dart
Firebase
Firebase Authentication
Cloud Firestore
Provider
Material 3
fl_chart
image_picker
intl
State Management
Cloud Data Management
Responsive UI Development
Mobile Application Development
```

---

# Project Status

**Status:** Active Development

The core application functionality has been implemented, including authentication, transaction CRUD operations, Firebase integration, financial summaries, graphical analytics, receipt attachments, multi-currency support, and theme customization.

Future development will focus on expanding budgeting, reporting, notification, and advanced financial analytics capabilities.
