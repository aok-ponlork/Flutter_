# e_commerce

This is a project with Flutter that connects to my Laravel API for my Mobile Application, developed during my academic year.

## Features

- User authentication (login/register)
- Product listing and details
- Cart management
- Order management

## Technologies Used

- **Flutter**: Frontend mobile application development
- **Lottie-File**: For animation, adding smooth, interactive animations to the app’s UI.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository**

    ```bash
    git clone https://github.com/yourusername/e_commerce.git
    ```

2. **Flutter Setup**

   - Make sure you have Flutter installed. If not, follow the installation guide: [Flutter Installation](https://flutter.dev/docs/get-started/install).
   - Install dependencies:

     ```bash
     flutter pub get
     ```

3. **Backend Setup**

   - Clone or download the backend Laravel API.
   - Navigate to the `backend` folder (or wherever you have the Laravel API stored).
   - Set up the environment variables (like database credentials, API keys, etc.) in `.env`.
   - Run the Laravel API:

     ```bash
     php artisan migrate
     php artisan serve
     ```

4. **Running the Flutter Application**

   After setting up both the API and Flutter app, you can run the app on an emulator or physical device:

   ```bash
   flutter run
   ```

## Resources

Here are a few resources that may be helpful while working on this project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook) for useful Flutter samples and best practices
- [Laravel Documentation](https://laravel.com/docs) for API development and setup
