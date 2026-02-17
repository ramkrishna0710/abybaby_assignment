# 🌾 Krishi Bikas

## Empowering Agriculture


Users can register, login, view dealer notifications, and securely logout from the application.

This application is built using Flutter and follows a clean and scalable architecture.

---

## ✨ Features

- ✅ User Registration
- ✅ Secure Login
- ✅ Dealer Notification Listing
- ✅ Logout Functionality
- ✅ Clean & Simple UI
- ✅ Scalable Architecture
- ✅ Production Ready

---

## 📦 Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/ramkrishna0710/abybaby_assignment
```

### 2️⃣ Navigate to the Project Directory

```bash
cd abybaby_assignment
```

### 3️⃣ Install Dependencies

```bash
flutter pub get
```

### 4️⃣ Run the Application

```bash
flutter run
```

---

## 🚀 Application Flow

### 📝 Step 1: Register

Register yourself by providing the following details:

- Name
- Email
- Gender
- Phone
- Password

After successful registration, the app will automatically navigate to the Login screen.

---

### 🔐 Step 2: Login

Login using:

- Email
- Password

After successful login, you will be redirected to the Dealer Notification Listing screen.

---

### 🔔 Step 3: Dealer Notification Listing

Once logged in, you will see:

- List of dealer notifications
- Notification title and description
- Category and type
- Location details

---

### 🚪 Logout

On the top-right corner of the notification screen, you will find an action button.

Tap it to securely logout from the application.

---

## 🏗️ Project Structure

```
lib/
│
├── core/
│   ├── api/
│   │   ├── api_exception.dart
│   │   ├── app_req_end_point.dart
│   │
│   ├── utils/
│   │   ├── app_settings.dart
│   │   ├── validators.dart
│   │   ├── common_button.dart
│   │
│
├── data/
│   │
│   ├── model/
│   │   ├── auth/
│   │   │   ├── user_model.dart
│   │   │   └── login_response_model.dart
│   │   │
│   │   ├── dealer/
│   │   │   ├── notification_model.dart
│   │   │   ├── dealer_enum.dart
│   │   │   └── country_model.dart
│   │
│   ├── repository/
│   │   ├── auth_repository.dart
│   │   └── dealer_repository.dart
│
│
├── domain/
│   │
│   ├── auth/
│   │   ├── auth_bloc.dart
│   │   ├── auth_event.dart
│   │   └── auth_state.dart
│   │
│   ├── dealer/
│   │   ├── dealer_bloc.dart
│   │   ├── dealer_event.dart
│   │   └── dealer_state.dart
│
│
├── features/
│   │
│   ├── auth/
│   │   ├── screens/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── splash_screen.dart
│   │
│   ├── dealer/
│   │   ├── screens/
│   │   │   ├── dealer_notification_list_screen.dart
│   │   │   └── widgets/
│   │   │       └── notification_card.dart
│
│
├── route/
│   └── app_routes.dart
│
└── main.dart

```

---

## 🧰 Tech Stack

- Flutter
- Dart
- flutter_bloc
- equatable
- REST API Integration

---

## ⚙️ Requirements

Ensure you have the following installed:

- Flutter SDK (latest stable)
- Android Studio or VS Code
- Android SDK
- Xcode (for iOS development)

Check your setup:

```bash
flutter doctor
```

---

## 🧪 Build Release

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios
```

---

## 👨‍💻 Author

Ramkrishna Mandal  
Flutter Developer  

---
