# 🍕 Meal App

A modern Flutter recipe application with authentication, cart system, and dark mode support. Built with Supabase for backend authentication and uses the DummyJSON Recipe API for recipe data.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

## 📱 Features

### 🔐 Authentication
- ✅ User Registration (Sign Up)
- ✅ User Login (Sign In)
- ✅ Password Reset (Forgot Password)
- ✅ Auto Login (Session Management)
- ✅ Secure Logout
- ✅ Profile Management

### 🍳 Recipe Features
- ✅ Browse 100+ Recipes
- ✅ Recipe Search
- ✅ Detailed Recipe View
- ✅ Ingredients List
- ✅ Step-by-step Instructions
- ✅ Cooking Time & Difficulty
- ✅ Rating & Reviews
- ✅ Cuisine Categories
- ✅ Infinite Scroll (Pagination)

### 🛒 Shopping Cart
- ✅ Add Recipes to Cart
- ✅ Adjust Quantities (+/-)
- ✅ Remove Items
- ✅ Price Calculation
- ✅ Tax & Delivery Fees
- ✅ Cart Badge Counter
- ✅ Checkout System
- ✅ Order Summary

### 👤 User Profile
- ✅ Profile Information Display
- ✅ Edit Profile
- ✅ Profile Picture Upload
- ✅ Statistics (Orders, Favorites, Reviews)
- ✅ Settings Management
- ✅ Notifications Toggle
- ✅ Language Selection
- ✅ Help & Support

### 🌓 Theme System
- ✅ Light Mode
- ✅ Dark Mode
- ✅ Theme Toggle Switch
- ✅ Persistent Theme Selection
- ✅ Custom Color Schemes

## 🛠️ Technologies Used

### Frontend
- **Flutter** - UI Framework
- **Dart** - Programming Language
- **Material Design** - UI Components

### State Management
- **flutter_bloc** (^8.1.3) - BLoC Pattern
- **Cubit** - State Management

### Backend & Authentication
- **Supabase** (^2.0.0) - Backend as a Service
- **supabase_flutter** - Supabase SDK for Flutter
- **GoTrue** - Authentication

### Data Persistence
- **shared_preferences** (^2.2.2) - Local Storage
  
### API
- **http** (^1.1.0) - HTTP Requests
- **DummyJSON Recipe API** - Recipe Data Source

### Other Libraries
- **path** (^1.8.3) - Path Manipulation

## 📁 Project Structure

```
lib/
├── main.dart                      # App Entry Point
├── Auth/
│   ├── auth_cubit.dart           # Authentication State Management
│   ├── auth_states.dart          # Auth States
│   ├── login_page.dart           # Login Screen
│   ├── signup_page.dart          # Sign Up Screen
│   └── forgot_password_page.dart # Password Reset
├── Models/
│   ├── recipe_model.dart         # Recipe Data Model
│   ├── order_model.dart          # Order Data Model
│   ├── cart_item_model.dart      # Cart Item Model
│   └── user_model.dart           # User Model
├── Data/
│   ├── recipe_api_service.dart   # Recipe API Calls
│   ├── database_helper.dart      # SQLite Database
│   └── supabase_service.dart     # Supabase Integration
├── Cubits/
│   ├── recipe_cubit.dart         # Recipe State Management
│   ├── cart_cubit.dart           # Cart State Management
│   ├── orders_cubit.dart         # Orders State Management
│   └── theme_cubit.dart          # Theme State Management
├── Views/
│   ├── home_page.dart            # Home Screen
│   ├── recipes_screen.dart       # Recipes Grid
│   ├── recipe_details_page.dart  # Recipe Details
│   ├── cart_page.dart            # Shopping Cart
│   ├── profile_page.dart         # User Profile
│   └── edit_profile_page.dart    # Edit Profile
├── Core/
│   ├── recipe_card.dart          # Recipe Card Widget
│   ├── cart_item_card.dart       # Cart Item Widget
│   └── cart_badge.dart           # Cart Badge Icon
└── Themes/
    └── app_themes.dart           # Light & Dark Themes
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Git
- Supabase Account

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/meal-app.git
cd meal-app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Set up Supabase**

   a. Create a Supabase account at https://supabase.com
   
   b. Create a new project
   
   c. Get your project credentials:
      - Go to Settings → API
      - Copy the **Project URL**
      - Copy the **anon/public key**

4. **Configure Supabase in the app**

Edit `lib/main.dart` and replace:
```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

5. **Enable Email Authentication in Supabase**
   - Dashboard → Authentication → Providers
   - Enable **Email** provider

6. **Run the app**
```bash
# For Web
flutter run -d chrome

# For Android
flutter run -d android

# For iOS
flutter run -d ios
```

## 📦 Dependencies

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  
  # Backend & Auth
  supabase_flutter: ^2.0.0
  
  # HTTP & API
  http: ^1.1.0
  
  # Local Storage
  shared_preferences: ^2.2.2
 
  path: ^1.8.3
  
```

Then run:
```bash
flutter pub get
```

## 🔧 Configuration




### API Configuration

The app uses DummyJSON Recipe API:
- Base URL: `https://dummyjson.com`
- Endpoints:
  - `GET /recipes` - Get all recipes
  - `GET /recipes/:id` - Get single recipe
  - `GET /recipes/search?q=query` - Search recipes

## 📱 Screenshots

### Authentication
- Login Screen
- Sign Up Screen
- Forgot Password

### Main Features
- Home Screen with Recipe Grid
- Recipe Details
- Shopping Cart
- Profile Page

### Themes
- Light Mode
- Dark Mode

## 🎨 Color Scheme

### Light Mode
- Primary: Orange (#FF9800)
- Background: Light Grey (#F5F5F5)
- Cards: White (#FFFFFF)
- Text: Black (#000000)

### Dark Mode
- Primary: Orange (#FF9800)
- Background: Dark Grey (#121212)
- Cards: Dark (#1E1E1E)
- Text: White (#FFFFFF)

## 🔐 Security

⚠️ **Important Security Notes:**

1. **Never commit sensitive keys**
   - Add `.env` to `.gitignore`
   - Use environment variables for API keys
   - Keep Supabase keys private

2. **Use .gitignore**
```gitignore
# Supabase keys
.env
*.env

# Flutter
.dart_tool/
.flutter-plugins
.packages
.pub/
build/
```

3. **Enable Row Level Security in Supabase**

## 📚 API Documentation

### Recipe API

**Get All Recipes**
```
GET https://dummyjson.com/recipes?skip=0&limit=30
```

**Get Recipe by ID**
```
GET https://dummyjson.com/recipes/:id
```

**Search Recipes**
```
GET https://dummyjson.com/recipes/search?q=pizza
```

### Response Format
```json
{
  "recipes": [
    {
      "id": 1,
      "name": "Classic Margherita Pizza",
      "ingredients": [...],
      "instructions": [...],
      "prepTimeMinutes": 20,
      "cookTimeMinutes": 15,
      "servings": 4,
      "difficulty": "Easy",
      "cuisine": "Italian",
      "caloriesPerServing": 300,
      "image": "https://...",
      "rating": 4.6,
      "reviewCount": 3
    }
  ],
  "total": 100,
  "skip": 0,
  "limit": 30
}
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/auth_test.dart
```

## 🐛 Troubleshooting

### Common Issues

**1. Supabase Connection Error**
```
Error: Failed to initialize Supabase
```
**Solution:** Check your URL and ANON_KEY are correct

**2. SQLite Error on Web**
```
Error: DatabaseFactory not initialized
```
**Solution:** Use SharedPreferences instead of SQLite for web

**3. Theme Not Persisting**
```
Theme resets after app restart
```
**Solution:** Ensure SharedPreferences is properly initialized

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@Mohamed27112020](https://github.com/Mohamed27112020)
- Email: ma422008@gmail.com

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Changelog

### Version 1.0.0 (2025-10-25)
- ✅ Initial release
- ✅ Authentication system with Supabase
- ✅ Recipe browsing and search
- ✅ Shopping cart functionality
- ✅ Order management
- ✅ User profile
- ✅ Dark mode support

## 🔮 Future Enhancements

- [ ] Favorite recipes
- [ ] Recipe ratings and reviews
- [ ] Social sharing
- [ ] Meal planning calendar
- [ ] Grocery list generator
- [ ] Offline mode
- [ ] Push notifications
- [ ] Multi-language support
- [ ] Recipe recommendations
- [ ] Cooking timer
- [ ] Nutritional information
- [ ] Video tutorials

## 📞 Support

For support, email ma422008@gmail.com or create an issue in the repository.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI Framework
- [Supabase](https://supabase.com/) - Backend & Auth
- [DummyJSON](https://dummyjson.com/) - Recipe API
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - State Management
- [Material Design](https://material.io/) - Design System

---

Made with ❤️ using Flutter
