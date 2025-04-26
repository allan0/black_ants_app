# BlackAnts App 🐜💰

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**BlackAnts: Your AI-powered gateway to African finance.**

Seamlessly **Save**, **Trade** cross-border stocks & **Invest** with personalized guidance. Our smart agents provide localized advice, connecting African opportunities to global investors & democratizing wealth creation. Unlock Africa's potential.

---

## ✨ Features

*   **AI-Powered Guidance:** Personalized financial advice tailored for African markets.
*   **Savings:** Tools and features to help users save effectively.
*   **Cross-Border Trading:** Access and trade stocks across different African markets.
*   **Investment Opportunities:** Connects users with investment options.
*   **Localized Advice:** Smart agents provide relevant financial insights.
*   **Global Connectivity:** Bridges African opportunities with global investors.

---

## 🚀 Getting Started

Follow these instructions to get the project up and running on your local machine.

**Prerequisites:**

*   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
*   An IDE like VS Code or Android Studio with Flutter plugins.
*   A connected device (physical or emulator) or Chrome browser for web testing.

**Installation & Running:**

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/allan0/black_ants_app.git
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd black_ants_app
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    *   For mobile (connected device/emulator):
        ```bash
        flutter run
        ```
    *   For web (Chrome):
        ```bash
        flutter run -d chrome
        ```

---

## 🏗️ Building for Web (GitHub Pages Example)

To create a web build suitable for deployment (e.g., to GitHub Pages):

1.  **Run the build command:**
    *   This command uses the HTML renderer (often better for SEO and initial load performance than CanvasKit) and sets the base URL path, crucial for deploying to a subdirectory like `https://<username>.github.io/<repo-name>/`.
    ```bash
    flutter build web --web-renderer html --base-href /black_ants_app/
    ```
2.  **Deploy:**
    *   Commit the contents of the `build/web` directory to your deployment branch (e.g., `gh-pages`).
    *   Configure your hosting service (like GitHub Pages) to serve files from that branch/directory.

---

## 💻 Technology Stack

*   **Frontend:** Flutter (Dart)
*   **Backend/DB:** Firebase 
*   **Platform Targets:** Android, iOS, Web (Linux, macOS, Windows also present as Flutter default targets)

---

## 📜 License

This project is licensed under the Apache-2.0 License - see the [LICENSE](LICENSE) file for details.

---

*Generated from GitHub repository data for allan0/black_ants_app.*
