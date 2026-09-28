# Expense Tracker

A cross-platform personal finance management application built with Flutter and Firebase. The application enables users to securely manage income and expenses, organize transactions, attach receipts, analyze spending patterns, and customize their experience through multi-currency and light/dark theme support.

The application uses Firebase Authentication for secure user accounts and Cloud Firestore for real-time cloud data synchronization.

---

## Table of Contents

* [Overview](#overview)
* [Features](#features)

  * [User Authentication](#user-authentication)
  * [Income and Expense Management](#income-and-expense-management)
  * [Transaction Categories](#transaction-categories)
  * [Receipt Attachments](#receipt-attachments)
  * [Financial Dashboard](#financial-dashboard)
  * [Real-Time Cloud Synchronization](#real-time-cloud-synchronization)
  * [Financial Analytics](#financial-analytics)
  * [Statistics](#statistics)
  * [Multi-Currency Support](#multi-currency-support)
  * [Theme Customization](#theme-customization)
  * [Profile and Settings](#profile-and-settings)
* [Technology Stack](#technology-stack)
* [Architecture](#architecture)
* [Project Structure](#project-structure)
* [Application Flow](#application-flow)
* [Transaction Flow](#transaction-flow)
* [Firebase Integration](#firebase-integration)
* [Data Isolation](#data-isolation)
* [Data Model](#data-model)
* [State Management](#state-management)
* [Recent Improvements](#recent-improvements)
* [Dependencies](#dependencies)
* [Getting Started](#getting-started)
* [Firebase Configuration](#firebase-configuration)
* [Running the Application](#running-the-application)
* [Testing](#testing)
* [Supported Platforms](#supported-platforms)
* [Security](#security)
* [UI and UX](#ui-and-ux)
* [Screenshots](#screenshots)
* [Future Improvements](#future-improvements)
* [Contributing](#contributing)
* [Issue Reporting](#issue-reporting)
* [License](#license)
* [Author](#author)
* [Project Status](#project-status)

---

# Overview

Expense Tracker is a personal finance management application designed to simplify the process of recording, monitoring, and analyzing financial activity.

The application provides users with a centralized platform for managing income and expenses while providing visual insights into their spending patterns.

Users can create and manage transactions, categorize financial activity, attach receipts, view financial summaries, analyze spending through interactive charts, and customize the application according to their preferences.

The application is built using Flutter and Firebase, allowing it to support multiple platforms while maintaining cloud-based data synchronization.

## Objectives

* Provide a simple interface for recording income and expenses.
* Allow users to create, view, edit, and delete financial transactions.
* Provide real-time synchronization using Cloud Firestore.
* Provide visual representations of spending and income.
* Help users understand their spending patterns.
* Keep financial data isolated between user accounts.
* Support multiple currencies.
* Provide light and dark theme customization.
* Maintain a modular and maintainable application architecture.
* Provide cross-platform support through Flutter.

---

# Features

## User Authentication

The application uses Firebase Authentication to provide secure account management.

Features include:

* User registration
* User login
* Authentication state management
* Automatic authentication routing
* Session management
* User logout
* User-specific data access

The application uses an `AuthWrapper` to determine whether the user should be directed to the authentication interface or the main application.

### Authentication Flow

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

---

## Income and Expense Management

Users can manage financial transactions through full CRUD functionality.

Supported operations:

* Create transactions
* View transactions
* Update transactions
* Delete transactions

Each transaction can contain:

* Amount
* Transaction type
* Category
* Date
* Payment method
* Notes
* Receipt image
* Timestamp
* User ID

The application supports both income and expense transactions.

---

## Transaction Categories

Transactions can be assigned to predefined financial categories.

### Expense Categories

* Food
* Transport
* Bills
* Shopping
* Entertainment
* Health

### Income Categories

* Salary
* Investment

Categories are used for transaction organization and financial analytics.

---

## Receipt Attachments

Users can attach receipt or bill images to individual transactions.

The application supports:

* Capturing images using the device camera
* Selecting images from the device gallery
* Previewing selected images
* Associating receipt images with transactions

Image selection and camera/gallery access are handled using the `image_picker` package.

---

## Financial Dashboard

The Home screen provides an overview of the user's financial activity.

The dashboard includes:

* Current net balance
* Total income
* Total expenses
* Recent transactions
* Monthly financial summary
* Spending overview
* Cloud synchronization status

Example:

```text
Net Balance
LKR 125,450.00

Total Income
LKR 185,000.00

Total Expenses
LKR 59,550.00
```

The dashboard is designed to provide users with a quick understanding of their current financial position.

---

## Real-Time Cloud Synchronization

The application uses Cloud Firestore real-time stream subscriptions to keep financial data synchronized with the cloud.

When a transaction is:

* Added
* Edited
* Deleted

the corresponding changes are automatically reflected in the application UI through Firestore's real-time data streams.

Users do not need to manually refresh the application to see synchronized transaction changes.

### Synchronization Flow

```text
User Action
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
Real-Time Stream
     |
     v
ExpenseProvider
     |
     v
Updated UI
```

### Sync Status Indicators

The application provides visible synchronization indicators in multiple areas.

#### Home Screen AppBar

A `Live Sync` badge indicates that the application is connected to the real-time synchronization system.

#### Monthly Summary Card

A `Synced with Cloud Firestore` indicator provides additional confirmation that financial data is synchronized with the cloud.

#### Settings and Profile

The Settings and Profile screen contains an account and Firebase service status section displaying:

* Firebase service status
* Firestore connectivity information
* Current authenticated user ID

Example:

```text
Account & Firebase Service Status

Status: Active
Service: Cloud Firestore
Synchronization: Active
User ID: <authenticated-user-id>
```

---

## Financial Analytics

The application provides graphical financial analytics using the `fl_chart` package.

Analytics include:

* Spending distribution
* Category-based spending
* Income versus expenses
* Spending trends
* Transaction summaries

Charts are generated from the user's transaction data.

---

## Statistics

The Statistics screen provides a dedicated interface for analyzing financial activity.

Users can view:

* Spending distribution by category
* Income versus expense comparisons
* Total income
* Total expenses
* Net balance
* Transaction counts
* Category spending information

Example:

```text
Food              32%
Bills             20%
Transport         18%
Shopping          15%
Entertainment     10%
Other              5%
```

The statistics interface provides a visual representation of financial activity, helping users identify spending patterns.

---

## Multi-Currency Support

The application supports dynamic currency selection.

Users can select their preferred currency through the settings interface.

Supported currencies can include:

* LKR — Sri Lankan Rupee
* USD — United States Dollar
* EUR — Euro
* GBP — British Pound
* INR — Indian Rupee
* AUD — Australian Dollar

Currency formatting is handled using the `intl` package.

The selected currency is applied throughout the application's financial interface.

---

## Theme Customization

The application supports light and dark themes using Material 3.

Available theme modes:

* Light
* Dark
* System Default

### Light Theme

| Purpose        | Colour    |
| -------------- | --------- |
| Primary        | `#10B981` |
| Primary Dark   | `#059669` |
| Background     | `#F8FAFC` |
| Surface        | `#FFFFFF` |
| Primary Text   | `#0F172A` |
| Secondary Text | `#64748B` |
| Border         | `#E2E8F0` |
| Income         | `#22C55E` |
| Expense        | `#EF4444` |
| Warning        | `#F59E0B` |

### Dark Theme

| Purpose        | Colour    |
| -------------- | --------- |
| Background     | `#0F172A` |
| Surface        | `#1E293B` |
| Primary        | `#34D399` |
| Primary Text   | `#F8FAFC` |
| Secondary Text | `#94A3B8` |
| Border         | `#334155` |
| Income         | `#4ADE80` |
| Expense        | `#F87171` |

---

## Profile and Settings

The Settings and Profile screen allows users to manage account and application preferences.

Features include:

* View profile information
* Manage account preferences
* Select preferred currency
* Change application theme
* View Firebase service status
* View Firestore synchronization status
* View authenticated user information
* Sign out

---

# Technology Stack

| Category                     | Technology              |
| ---------------------------- | ----------------------- |
| Framework                    | Flutter                 |
| Programming Language         | Dart                    |
| UI Framework                 | Material 3              |
| State Management             | Provider                |
| Authentication               | Firebase Authentication |
| Database                     | Cloud Firestore         |
| Charts                       | fl_chart                |
| Image Handling               | image_picker            |
| Date and Currency Formatting | intl                    |
| Backend Services             | Firebase                |
| Platforms                    | Android, iOS, Web       |

---

# Architecture

The application follows a layered architecture that separates the user interface, application state, business logic, external services, and data models.

```text
Presentation Layer
        |
        v
State Management Layer
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

This separation improves:

* Maintainability
* Scalability
* Testability
* Code organization
* Separation of responsibilities

---

## Presentation Layer

The presentation layer contains application screens and reusable UI components.

```text
screens/
widgets/
```

Responsibilities include:

* Rendering application screens
* Handling user interaction
* Displaying financial information
* Displaying charts
* Managing forms
* Displaying loading states
* Displaying error states
* Displaying synchronization status

---

## State Management Layer

The application uses Provider for application state management.

```text
providers/
```

### AuthProvider

Responsible for:

* Authentication state
* Current authenticated user
* Login status
* Logout operations

### ExpenseProvider

Responsible for:

* Loading transactions
* Adding transactions
* Updating transactions
* Deleting transactions
* Maintaining transaction state
* Calculating financial summaries
* Listening to real-time Firestore updates
* Updating the UI when Firestore data changes

Transaction saving and updating are handled without unnecessary global loading-state triggers. This allows the application interface to remain responsive while financial records are being saved or updated.

### ThemeProvider

Responsible for:

* Light theme
* Dark theme
* System theme
* Theme switching

### CurrencyProvider

Responsible for:

* Selected currency
* Currency changes
* Currency formatting

---

## Services Layer

```text
services/
```

The services layer separates external services and business operations from the user interface.

### AuthService

Handles Firebase Authentication operations including:

* User registration
* User login
* User logout
* Authentication state

### FirestoreService

Handles Cloud Firestore operations including:

* Creating transactions
* Reading transactions
* Updating transactions
* Deleting transactions
* Retrieving user-specific transactions
* Providing real-time transaction streams

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
├── firebase_options.dart
│
└── main.dart
```

---

# Application Flow

The primary application flow is:

```text
Application Launch
        |
        v
Firebase Initialization
        |
        v
Authentication Check
        |
        +----------------------+
        |                      |
        v                      v
   Logged Out              Logged In
        |                      |
        v                      v
Login / Register           Home Screen
                               |
                +--------------+--------------+
                |              |              |
                v              v              v
          Transactions     Statistics     Settings
                |
                v
        Add / Edit Transaction
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
Real-Time Firestore Stream
 |
 v
ExpenseProvider
 |
 v
Updated UI
```

The use of real-time Firestore streams means that changes are reflected in the application without requiring a manual refresh.

---

# Firebase Integration

The application uses Firebase as its cloud backend.

## Firebase Services

```text
Firebase Core
Firebase Authentication
Cloud Firestore
```

---

## Firebase Initialization

Firebase is explicitly initialized using platform-specific configuration.

The application uses:

```dart
Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

The Firebase configuration is provided through:

```text
lib/firebase_options.dart
```

Using `DefaultFirebaseOptions.currentPlatform` ensures that the appropriate Firebase configuration is selected for the current platform.

This is particularly important for mobile deployments such as Android and iOS.

---

## Firebase Authentication

Firebase Authentication is responsible for:

* User registration
* User login
* Authentication state
* User sessions
* Logout

---

## Cloud Firestore

Cloud Firestore is responsible for:

* Storing financial transactions
* Real-time transaction synchronization
* Transaction creation
* Transaction updates
* Transaction deletion
* User-specific financial data

The application uses Firestore stream subscriptions to receive changes in real time.

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

A transaction can contain:

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

# Recent Improvements

The following improvements were implemented to improve Firebase reliability, application responsiveness, and synchronization visibility.

## Firebase Initialization

Updated `lib/main.dart` to explicitly initialize Firebase with:

```dart
Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

This ensures that the correct Firebase configuration from `lib/firebase_options.dart` is used for the current platform.

This improves Firebase Authentication and Cloud Firestore initialization on supported mobile platforms.

---

## ExpenseProvider Improvements

Updated:

```text
lib/providers/expense_provider.dart
```

The `addExpense` and `updateExpense` operations were improved to avoid unnecessary global loading-state triggers.

Previously, unnecessary loading state changes could block parts of the interface and result in an unresponsive or frozen UI during transaction operations.

The updated implementation allows transaction operations to complete while keeping the interface responsive.

---

## Real-Time Firestore Synchronization

Cloud Firestore stream subscriptions are used to automatically propagate transaction changes to the application.

This means:

```text
Add Transaction
       |
       v
Cloud Firestore
       |
       v
Firestore Stream
       |
       v
ExpenseProvider
       |
       v
UI Automatically Updated
```

The same process applies when transactions are edited or deleted.

---

## Synchronization Status Indicators

The application now provides visible synchronization information.

### Home AppBar

A `Live Sync` badge indicates the availability of real-time synchronization.

### Monthly Summary

A `Synced with Cloud Firestore` indicator communicates that the financial summary is synchronized with the cloud.

### Settings and Profile

An `Account & Firebase Service Status` section provides Firebase and Firestore service information, including the authenticated user's ID.

These indicators improve transparency by allowing users to understand the application's cloud synchronization state.

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

* Flutter SDK
* Dart SDK
* Android Studio or Visual Studio Code
* Git
* A Firebase project

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

Create a Firebase project and configure the required Firebase services.

Enable:

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

This generates the platform-specific Firebase configuration used by:

```text
lib/firebase_options.dart
```

Do not commit private credentials or sensitive configuration values that should not be publicly exposed.

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

* Android
* iOS
* Web

Additional platform-specific configuration may be required for Firebase and camera/gallery functionality.

---

# Security

Security is important because the application handles personal financial information.

The application uses Firebase Authentication to identify users and associates transactions with authenticated user IDs.

Production Firestore Security Rules should restrict users to their own data.

A conceptual access rule is:

```text
A user may access a transaction only when:

transaction.userId == request.auth.uid
```

Firebase credentials and other sensitive configuration values should not be hard-coded into application source code.

Authentication and database security rules should be reviewed before production deployment.

---

# UI and UX

The application follows a clean, modern fintech-inspired design system.

## Design Principles

### Clarity

Financial information should be understandable at a glance.

### Consistency

Reusable components maintain consistent spacing, typography, colours, and interaction patterns.

### Visual Hierarchy

Important information such as net balance, income, and expenses receives stronger visual emphasis.

### Accessibility

The interface uses appropriate colour contrast and readable typography.

### Minimalism

The interface focuses on essential financial information and actions without unnecessary visual elements.

### Responsiveness

Layouts are designed to adapt to different screen sizes and platforms.

---

# Screenshots

Add screenshots of the application to this section.

Recommended screenshots:

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
├── firebase_sync.png
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

### Settings and Firebase Status

![Settings](screenshots/settings.png)
```

---

# Future Improvements

Potential future improvements include:

* Budget management
* Monthly and yearly spending limits
* Budget notifications
* Recurring transactions
* Savings goals
* CSV export
* PDF financial reports
* Advanced transaction filtering
* Multiple financial accounts
* Push notifications
* Receipt OCR
* Automatic transaction categorization
* Advanced financial analytics
* AI-powered spending insights
* Cloud Storage integration for receipt images
* Financial forecasting

---

# Project Development Practices

The project follows development practices intended to improve maintainability and scalability.

These include:

* Separation of UI and business logic
* Provider-based state management
* Reusable widgets
* Service abstraction for Firebase operations
* Model-based data representation
* Centralized theme configuration
* Centralized application colours
* Modular project structure
* Real-time Firestore data streams
* User-specific data handling
* Responsive transaction operations
* Platform-specific Firebase configuration

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

* Description of the issue
* Steps to reproduce
* Expected behaviour
* Actual behaviour
* Device and operating system
* Flutter version
* Relevant screenshots
* Error logs, if available

---

# License

This project is currently intended for educational and portfolio purposes.

A suitable open-source or proprietary license should be added before distributing the application publicly or commercially.

---

# Author

**Your Name**

Software Engineering Student / Developer

### Technologies Demonstrated

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
Real-Time Synchronization
Responsive UI Development
Mobile Application Development
```

---

# Project Status

**Status:** Completed

The application currently provides:

* Firebase Authentication
* User registration and login
* Transaction CRUD operations
* Cloud Firestore integration
* Real-time transaction synchronization
* Firebase platform-specific initialization
* Responsive transaction saving and editing
* Financial summaries
* Interactive financial analytics
* Receipt attachments
* Transaction categorization
* Multi-currency support
* Light and dark themes
* Firebase synchronization status indicators
* Provider-based state management
* Modular application architecture

The project can be extended in future iterations with budgeting, advanced reporting, notifications, automated receipt processing, and additional financial analytics.
