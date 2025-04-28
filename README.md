
# Internship: A Sample internship Application

## Overview

Our Internship App is designed to simplify the process of finding, applying for, and managing internships. Built using Flutter, it provides a user-friendly interface where students can browse available internships, apply directly through the app, and track their application status. It also helps companies post internship opportunities easily and connect with the right candidates.

The app aims to bridge the gap between students seeking real-world experience and companies looking for fresh talent. With features like real-time updates, notifications, and personalized recommendations, our Internship App makes the entire journey smooth, efficient, and accessible to everyone.



## Features

- Student Registration & Login
- Students can easily create an account and log in securely.
- Company Registration & Login
- Companies can sign up to post internships and manage applicants.
- Internship Listings
- Browse a list of available internships with details like role, duration, location, and stipend.
- Search and Filter Internships
- Smart search and filters by category, location, duration, paid/unpaid, etc.
- Apply for Internships
- Students can apply directly from the app with their profile/resume.
- Application Tracking
-Students can track the status of their applications (applied, shortlisted, selected).
-Internship Posting (for Companies)
-Companies can post new internship opportunities with all necessary details.
- Profile Management

## Clean Architecture

Clean Architecture is a software design philosophy that separates the concerns of an application into layers, each with a specific responsibility. The layers typically include:

1. **Presentation Layer**: Handles UI-related logic and interacts .
2. **Domain Layer**: Contains business logic, usecase,entities .
3. **Data Layer**: Manages data access, including interactions with local and remote data sources.

The separation of concerns makes the codebase modular, scalable, and easy to maintain.

## Libraries Used

- **google_sign_in**: Sign in with Google for faster login
- **cloud_firestore**: For storing a data in database.
- **firebase_core**: A Flutter plugin to use the Firebase Core API, which enables connecting to multiple Firebase apps.
- **firebase_auth**: Authentication (Login/Register students and companies)


## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

- Flutter installed on your machine ([Installation Guide](https://flutter.dev/docs/get-started/install))
- Emulator or physical device for testing

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/zahra-choksi/internship_app.git
2. Change into the project directory:

   ```bash
    cd internship_app
3. Install dependencies:

    ```bash
    flutter pub get
4. Run the app:

    ```bash
   flutter run

