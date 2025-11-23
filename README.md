# News App

A Flutter news experience inspired by the provided mockups: curated categories, light/dark themes, Arabic/English toggle, rich article cards, detail pages, and search powered by NewsAPI.

## Highlights
- Splash screen with custom `news_logo.png`.
- Home categories (General, Business, Sports, Technology, Health, Science, Entertainment) using the supplied assets with light/dark variants.
- Drawer controls: theme switch (light/dark/system) and language toggle (English/Arabic).
- Category feeds with loading/error/empty states; tap to open a full article view or launch the original link.
- Search across all news; cached images and typography via Google Fonts.

## Tech Stack
- Flutter 3.x, Dart
- State: `provider`
- HTTP + dotenv for secure API key loading
- UI: Google Fonts, Material 3 theming
- Media: `cached_network_image`, `url_launcher`

## Getting Started
1) Install Flutter SDK and set up an emulator/device.
2) Clone the repo and fetch packages:
   ```bash
   flutter pub get
   ```
3) Add environment variables in `.env` (already ignored by git):
   ```env
   NEWS_API_KEY=840b1d72d36747fababae583647c1ac5
   ```
4) Run the app:
   ```bash
   flutter run
   ```

## Project Structure (key bits)
- `lib/main.dart` — app entry, theme/language providers, routing.
- `lib/screens/` — splash, home, category feed, article detail, search.
- `lib/widgets/` — category cards, news cards, drawer UI.
- `lib/services/news_api_service.dart` — NewsAPI integration with Arabic fallback for sparse top-headlines.
- `assets/` — all provided category artwork plus `news_logo.png` for splash.

## Notes
- Arabic mode uses the `everything` endpoint when top-headlines lack results, so you still see relevant Arabic stories.
- Keep your `.env` out of version control (already covered in `.gitignore`).
- If Gradle/Kotlin daemon errors occur, run `./gradlew --stop`, `flutter clean`, then retry `flutter run`.
