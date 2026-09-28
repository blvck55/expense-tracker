# Expense Tracker

A cross-platform personal finance management application built with Flutter, Dart, and Firebase.

Expense Tracker allows users to securely manage their income and expenses, analyze spending patterns through interactive visualizations, attach receipt images, search and filter transactions, and customize currency and theme preferences.

The application uses Firebase Authentication and Cloud Firestore for user authentication, cloud storage, real-time synchronization, and offline data persistence, while SharedPreferences is used for persistent local application preferences.

---

## Table of Contents

* [Overview](#overview)
* [Key Features](#key-features)

  * [User Authentication](#1-user-authentication)
  * [Real-Time Expense Management](#2-real-time-expense-management-crud)
  * [Analytics and Insights](#3-analytics-and-insights)
  * [Search and Multi-Criteria Filtering](#4-search-and-multi-criteria-filtering)
  * [Currency and Theme Preferences](#5-persistent-currency-and-theme-preferences)
  * [Real-Time Cloud Synchronization](#6-real-time-cloud-synchronization)
* [Technology Stack](#technology-stack)
* [Architecture](#architecture)
* [Project Structure](#project-structure)
* [Application Flow](#application-flow)
* [Transaction Data Flow](#transaction-data-flow)
* [Firebase Integration](#firebase-integration)
* [Data Model](#data-model)
* [State Management](#state-management)
* [UI and UX](#ui-and-ux)
* [Getting Started](#getting-started)
* [Firebase Configuration](#firebase-configuration)
* [Running the Application](#running-the-application)
* [Testing and Code Quality](#testing-and-code-quality)
* [Supported Platforms](#supported-platforms)
* [Security](#security)
* [Screenshots](#screenshots)
* [Future Improvements](#future-improvements)
* [Contributing](#contributing)
* [License](#license)
* [Author](#author)
* [Project Status](#project-status)

---

# Overview

Expense Tracker is a personal finance management application designed to provide users with a simple and centralized way to record, manage, search, and analyze their financial transactions.

The application combines a modern Material 3 interface with Firebase-powered cloud synchronization and local preference persistence.

Users can:

* Create income and expense records
* Edit and delete transactions
* Categorize financial activity
* Attach receipt images
* Search transactions
* Apply multiple filters
* Navigate between monthly summaries
* Analyze spending using interactive charts
* Select a preferred currency
* Switch between light, dark, and system themes
* Synchronize financial data in real time

---

# Key Features

## 1. User Authentication

The application uses Firebase Authentication to provide secure account management.

### Features

* Email and password registration
* Email and password sign-in
* Automatic authentication state monitoring
* Persistent user sessions
* Automatic login state restoration
* User-specific transaction data
* Authenticated user ID tracking
* Account and Firebase service status indicators
* Secure logout

### Authentication Flow

```text
Application Launch
        |
        v
Firebase Initialization
        |
        v
Authentication State Check
        |
        +----------------------+
        |                      |
        v                      v
   Logged Out              Logged In
        |                      |
        v                      v
Login / Register           Home Screen
```

The authentication state is managed through `AuthProvider` and the Firebase Authentication service.

---

# 2. Real-Time Expense Management (CRUD)

The application provides complete CRUD functionality for financial transactions.

CRUD operations include:

* Create
* Read
* Update
* Delete

## Add Expense

Users can create a new transaction containing:

* Title
* Amount
* Category
* Date
* Optional notes
* Receipt image
* Transaction information

## Edit and Update

Existing transactions can be edited and updated.

Changes are synchronized with Cloud Firestore and reflected in the application through the real-time Firestore stream.

## Delete Expense

Users can delete transactions through a confirmation process to reduce accidental deletion.

## Receipt Attachments

Users can attach receipt images to transactions.

Supported sources include:

* Device camera
* Device gallery

Receipt images are processed for use within the application and can be displayed as transaction previews.

---

# 3. Analytics and Insights

Expense Tracker provides visual analytics to help users understand their spending patterns.

## Monthly Summary

The dashboard provides a monthly financial summary that calculates the total expenses for the currently selected month.

Users can navigate between months using:

* Previous month
* Current month
* Next month

The summary is recalculated based on the selected month and available transactions.

## Interactive Pie Charts

The application uses `fl_chart` to provide interactive visualizations of transaction categories.

Example:

```text
          Expense Distribution

              Food
               35%

     Bills              Shopping
      20%                  18%

          Transport
             15%

        Entertainment
              12%
```

## Category Breakdown

The application provides a detailed category breakdown containing:

* Category name
* Total amount
* Percentage of overall expenses
* Visual representation

This allows users to identify which categories contribute most to their spending.

---

# 4. Search and Multi-Criteria Filtering

The application provides flexible transaction discovery through multiple filtering mechanisms.

## Keyword Search

Users can dynamically search transactions using:

* Transaction title
* Description or notes

Search results update as the user enters text.

## Category Filter

Transactions can be filtered according to their category.

Example categories include:

* Food
* Utilities
* Transportation
* Entertainment
* Shopping
* Bills
* Health
* Other supported categories

## Date Range Filter

Users can select a custom date range to display transactions within a specific period.

For example:

```text
01 September 2026
        |
        v
30 September 2026
```

Only transactions falling within the selected date interval are displayed.

## Combined Filtering

Search, category, and date filters can be used together to narrow down transaction results.

Conceptually:

```text
All Transactions
       |
       +---- Keyword Search
       |
       +---- Category Filter
       |
       +---- Date Range
       |
       v
Filtered Transactions
```

## Clear Filters

A dedicated `Clear Filters` control allows users to reset the active filters with one action.

---

# 5. Persistent Currency and Theme Preferences

The application provides customizable financial display preferences.

## Multi-Currency Support

Supported currencies include:

| Currency                    | Code |
| --------------------------- | ---- |
| Sri Lankan Rupee            | LKR  |
| United States Dollar        | USD  |
| Euro                        | EUR  |
| British Pound               | GBP  |
| Indian Rupee                | INR  |
| Australian Dollar           | AUD  |
| Canadian Dollar             | CAD  |
| Japanese Yen                | JPY  |
| Singapore Dollar            | SGD  |
| United Arab Emirates Dirham | AED  |
| Saudi Riyal                 | SAR  |
| New Zealand Dollar          | NZD  |

Currency formatting is handled using the `intl` package.

## Persistent Preferences

The application uses `SharedPreferences` to store user-selected preferences locally.

Persisted settings include:

* Selected currency
* Theme preference

This means the selected settings remain available after the application is closed and reopened.

## Theme Modes

The application supports:

* Light Mode
* Dark Mode
* System Default

The theme system is built using Material 3.

---

# 6. Real-Time Cloud Synchronization

Cloud Firestore is used to provide real-time transaction synchronization.

When a transaction is added, edited, or deleted, the Firestore stream updates the application state automatically.

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
Real-Time Document Stream
     |
     v
ExpenseProvider
     |
     v
Updated UI
```

This eliminates the need for users to manually refresh the transaction list after making changes.

## Live Sync Indicator

The Home screen displays a `Live Sync` status indicator to communicate the application's cloud synchronization state.

## Cloud Sync Summary

The monthly summary area also provides a `Synced with Cloud Firestore` status indicator.

## Firebase Service Status

The Settings screen provides an account and Firebase service status section containing information such as:

* Firebase service status
* Firestore synchronization state
* Authenticated user ID

These indicators provide greater transparency regarding the application's cloud connectivity and synchronization state.

---

# Technology Stack

| Layer             | Technology / Package    | Purpose                                      |
| ----------------- | ----------------------- | -------------------------------------------- |
| Framework         | Flutter 3.x             | Cross-platform application development       |
| Language          | Dart                    | Application programming language             |
| UI                | Material 3              | Application design system                    |
| State Management  | Provider `^6.1.2`       | Application state management                 |
| Authentication    | Firebase Authentication | User authentication and sessions             |
| Firebase Core     | firebase_core           | Firebase platform initialization             |
| Database          | Cloud Firestore         | Cloud database and real-time synchronization |
| Local Persistence | shared_preferences      | Persistent local preferences                 |
| Analytics         | fl_chart `^0.68.0`      | Charts and financial visualization           |
| Media             | image_picker `^1.1.2`   | Camera and gallery image selection           |
| Formatting        | intl `^0.19.0`          | Currency and date formatting                 |

---

# Architecture

The application follows a layered architecture that separates presentation, state management, services, and persistence.

```text
┌─────────────────────────────────────────────┐
│           Presentation Layer                │
│                                             │
│ Screens • Widgets • Dialogs                 │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│         State Management Layer              │
│                                             │
│ MultiProvider                               │
│ ├── AuthProvider                            │
│ ├── ExpenseProvider                         │
│ ├── ThemeProvider                           │
│ └── CurrencyProvider                        │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│             Services Layer                  │
│                                             │
│ AuthService                                 │
│ FirestoreService                            │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│       Data Persistence & Backend            │
│                                             │
│ Cloud Firestore                             │
│ ├── Remote database                         │
│ └── Offline persistence                     │
│                                             │
│ SharedPreferences                           │
│ └── Local user preferences                  │
└─────────────────────────────────────────────┘
```

---

# Project Structure

```text
lib/
│
├── app/
│   ├── constants/
│   │   ├── categories.dart
│   │   ├── icons.dart
│   │   └── colors.dart
│   │
│   └── theme/
│       ├── app_theme.dart
│       └── theme configuration
│
├── models/
│   └── expense_model.dart
│       └── Data model and Firestore serializer
│
├── providers/
│   ├── auth_provider.dart
│   │   └── Authentication state management
│   │
│   ├── currency_provider.dart
│   │   └── Persistent currency selection
│   │
│   ├── expense_provider.dart
│   │   └── CRUD operations and live filtering
│   │
│   └── theme_provider.dart
│       └── Persistent light/dark theme state
│
├── screens/
│   │
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
│       ├── empty_state.dart
│       └── image preview widgets
│
├── services/
│   ├── auth_service.dart
│   │   └── Firebase Authentication service
│   │
│   └── firestore_service.dart
│       └── Cloud Firestore streaming and CRUD
│
├── firebase_options.dart
│   └── Platform-specific Firebase configuration
│
└── main.dart
    └── Firebase initialization and root application widget
```

---

# Application Flow

The overall application flow is:

```text
Application Launch
        |
        v
Firebase Initialization
        |
        v
Authentication State
        |
        +--------------------------+
        |                          |
        v                          v
   Not Authenticated          Authenticated
        |                          |
        v                          v
 Login / Register              Home Screen
                                   |
              +--------------------+--------------------+
              |                    |                    |
              v                    v                    v
        Transactions          Statistics           Settings
              |
              v
       Add / Edit Expense
              |
              v
       Cloud Firestore
              |
              v
      Real-Time UI Update
```

---

# Transaction Data Flow

A transaction follows the following process when it is created or modified:

```text
User
 |
 | Add / Edit Transaction
 v
ExpenseProvider
 |
 v
FirestoreService
 |
 v
Cloud Firestore
 |
 | Real-Time Snapshot
 v
ExpenseProvider
 |
 v
Filtered / Calculated State
 |
 v
UI
```

The same architecture supports:

* Adding transactions
* Updating transactions
* Deleting transactions
* Filtering transactions
* Monthly calculations
* Analytics

---

# Firebase Integration

Firebase provides the application's backend infrastructure.

## Firebase Services Used

### Firebase Core

Responsible for initializing Firebase for the current platform.

The application uses:

```dart
Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

The platform-specific configuration is stored in:

```text
lib/firebase_options.dart
```

### Firebase Authentication

Used for:

* User registration
* User login
* Session management
* Authentication state monitoring
* Logout

### Cloud Firestore

Used for:

* Transaction storage
* Transaction CRUD operations
* Real-time document streaming
* User-specific data
* Offline persistence

---

# Firestore Real-Time Streaming

The application uses Firestore document snapshot streams to receive transaction changes.

Conceptually:

```dart
Stream<List<ExpenseModel>>
```

The stream allows the application to react to changes in Firestore without requiring manual refresh operations.

For example:

```text
Device A
   |
   | Add Transaction
   v
Cloud Firestore
   |
   | Snapshot Update
   v
ExpenseProvider
   |
   v
Updated UI
```

---

# Offline Persistence

Cloud Firestore provides local caching and offline persistence capabilities.

This allows the application to maintain a locally available representation of Firestore data and synchronize changes when connectivity is restored, subject to the Firebase platform configuration and Firestore behavior.

This improves the application's resilience when network connectivity is temporarily unavailable.

---

# Data Model

The main transaction data model is:

```text
ExpenseModel
```

A transaction can contain information such as:

```text
id
userId
title
amount
category
date
notes
receipt/image data
createdAt
```

The model is responsible for converting transaction data between the application representation and Firestore documents.

It also supports creating modified copies of transactions through `copyWith`.

---

# State Management

The application uses the Provider package with a `MultiProvider` architecture.

## AuthProvider

Responsible for:

* Authentication state
* Current authenticated user
* Login state
* Logout
* Authentication changes

## ExpenseProvider

Responsible for:

* Transaction state
* Firestore transaction streams
* Adding expenses
* Updating expenses
* Deleting expenses
* Search
* Category filtering
* Date range filtering
* Clearing filters
* Monthly calculations
* Expense summaries
* Category breakdowns

The provider also ensures that Firestore changes are propagated to the UI in real time.

## ThemeProvider

Responsible for:

* Light theme
* Dark theme
* System theme
* Persisting theme preference

## CurrencyProvider

Responsible for:

* Currency selection
* Currency persistence
* Currency formatting

---

# UI and UX

The application follows a modern Material 3 design system.

## Design Principles

### Clear Financial Hierarchy

Important financial information such as:

* Total expenses
* Total income
* Net balance
* Monthly totals

is given visual priority.

### Consistent Components

Reusable components are used for:

* Transaction cards
* Summary cards
* Empty states
* Dialogs
* Image previews
* Filter controls

### Responsive Interface

Flutter's cross-platform UI system allows the application to adapt to supported screen sizes and platforms.

### Light and Dark Themes

The interface supports:

```text
Light Mode
Dark Mode
System Default
```

### Feedback

The application provides feedback for important operations such as:

* Adding transactions
* Updating transactions
* Deleting transactions
* Filtering
* Synchronization
* Authentication

---

# Getting Started

## Prerequisites

Before running the project, install:

* Flutter SDK
* Dart SDK
* Android Studio or Visual Studio Code
* Git
* Firebase project

Verify Flutter:

```bash
flutter doctor
```

---

# Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
```

Navigate to the project:

```bash
cd expense_tracker
```

Install dependencies:

```bash
flutter pub get
```

---

# Firebase Configuration

Create a Firebase project through the Firebase Console.

Enable the required services:

```text
Firebase Authentication
Cloud Firestore
```

Configure Email/Password authentication.

Install FlutterFire CLI if required:

```bash
dart pub global activate flutterfire_cli
```

Configure Firebase:

```bash
flutterfire configure
```

This generates the required Firebase configuration file:

```text
lib/firebase_options.dart
```

The application initializes Firebase using:

```dart
Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

---

# Firestore Configuration

Create the required Firestore database in the Firebase Console.

Configure appropriate Firestore Security Rules before production deployment.

A transaction should be associated with the authenticated user's Firebase UID.

Conceptually:

```text
Transaction
    |
    └── userId
          |
          └── Firebase Authentication UID
```

This association allows application logic and Firestore Security Rules to enforce user-specific data access.

---

# Running the Application

Check available devices:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

Run on a specific device:

```bash
flutter run -d <device-id>
```

---

# Testing and Code Quality

Run Flutter tests:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

Format the project:

```bash
dart format .
```

These commands help maintain code consistency and identify potential issues before deployment.

---

# Supported Platforms

The application is designed as a cross-platform Flutter application.

Supported targets include:

* Android
* iOS
* Web

Some Firebase and device-specific features may require additional platform configuration.

For example, camera and gallery functionality may require appropriate platform permissions.

---

# Security

Because the application handles personal financial information, appropriate security practices should be followed.

## Authentication

Firebase Authentication is used to identify users securely.

## User-Specific Data

Transactions are associated with the authenticated user's Firebase UID.

## Firestore Security Rules

Production Firestore rules should ensure that users can only access their own financial records.

Conceptually:

```text
Authenticated User
        |
        v
Firebase UID
        |
        v
Transaction.userId
        |
        v
Access Allowed
```

Requests where the authenticated UID does not match the transaction's user ID should be rejected by the database security rules.

## Sensitive Configuration

Sensitive credentials and private configuration information should not be committed to public repositories.

---

# Screenshots

Add application screenshots to demonstrate the main functionality.

Recommended screenshots:

```text
screenshots/
│
├── login.png
├── register.png
├── home.png
├── add-expense.png
├── edit-expense.png
├── search-filter.png
├── statistics.png
├── settings.png
├── live-sync.png
└── dark-mode.png
```

Example Markdown:

```markdown
## Screenshots

### Login

![Login Screen](screenshots/login.png)

### Dashboard

![Dashboard](screenshots/home.png)

### Add Expense

![Add Expense](screenshots/add-expense.png)

### Search and Filtering

![Search and Filtering](screenshots/search-filter.png)

### Statistics

![Statistics](screenshots/statistics.png)

### Settings

![Settings](screenshots/settings.png)

### Dark Mode

![Dark Mode](screenshots/dark-mode.png)
```

---

# Future Improvements

Potential future enhancements include:

* Budget creation and tracking
* Monthly spending limits
* Budget notifications
* Recurring transactions
* Savings goals
* Financial report generation
* CSV export
* PDF report generation
* Advanced transaction sorting
* Advanced financial filtering
* Push notifications
* Receipt OCR
* Automatic receipt categorization
* Automatic transaction categorization
* Cloud Storage for receipt images
* Multiple financial accounts
* Financial forecasting
* Advanced financial insights
* AI-assisted spending analysis

---

# Project Development Practices

The project demonstrates several software development practices:

* Layered application architecture
* Provider-based state management
* Separation of UI and business logic
* Service-based Firebase integration
* Reusable Flutter widgets
* Model-based data representation
* Real-time Firestore streams
* Local preference persistence
* Responsive UI design
* Material 3 design system
* User-specific data management
* CRUD implementation
* Multi-criteria filtering
* Financial data visualization
* Cross-platform development

---

# Contributing

Contributions are welcome.

## 1. Fork the Repository

Create your own fork of the project.

## 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature
```

## 3. Make Your Changes

Implement the required feature or fix.

## 4. Test the Application

Run:

```bash
flutter analyze
flutter test
```

## 5. Format the Code

```bash
dart format .
```

## 6. Commit Your Changes

```bash
git commit -m "Add your feature"
```

## 7. Push Your Branch

```bash
git push origin feature/your-feature
```

## 8. Create a Pull Request

Provide a clear description of the changes and include relevant screenshots where appropriate.

---

# License

This project is currently intended for educational, portfolio, and demonstration purposes.

If the project is distributed publicly or commercially, an appropriate open-source or proprietary license should be added.

---

# Author

**Your Name**

Software Engineering Student / Developer

## Technologies Demonstrated

```text
Flutter
Dart
Firebase
Firebase Authentication
Cloud Firestore
Provider
Material 3
SharedPreferences
fl_chart
image_picker
intl
State Management
Real-Time Data Synchronization
CRUD Operations
Financial Analytics
Responsive UI Development
Cross-Platform Application Development
```

---

# Project Status

**Status: Completed**

The current implementation includes:

* Firebase Authentication
* Email/password registration and login
* Persistent authentication sessions
* User-specific transaction management
* Full transaction CRUD
* Receipt image attachments
* Camera and gallery support
* Real-time Cloud Firestore synchronization
* Firestore offline persistence
* Monthly expense summaries
* Previous/next month navigation
* Interactive category pie charts
* Category percentage breakdowns
* Keyword search
* Category filtering
* Custom date-range filtering
* Clear filter functionality
* Multi-criteria transaction filtering
* Multi-currency support
* Persistent currency preferences
* Light mode
* Dark mode
* System default theme
* Persistent theme preferences
* Firebase service status indicators
* Live synchronization indicators
* Provider-based state management
* Material 3 UI
* Cross-platform Flutter architecture

The project provides a complete foundation for a personal finance management application and can be extended with budgeting, financial reports, notifications, OCR-based receipt processing, and advanced financial analytics.
