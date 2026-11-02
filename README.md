# KonnectMe

A Flutter video meeting app using Clerk authentication and ZEGO UIKit. The meeting lounge adapts to phone and desktop widths, with shared Material 3 styling and reusable interface components.

## Setup

1. Install Flutter with Dart 3.13.5 or newer, matching `pubspec.yaml`.
2. Copy `.env.example` to `.env` and enter your ZEGO App ID, App Sign, and Clerk **publishable** key. The existing `CLERK_API_KEY` variable expects a publishable key, never a Clerk secret key.
3. Run `flutter pub get`.
4. Run `flutter run` on a supported device.

Use the same meeting ID on two devices to join the same call. IDs accept 1–64 letters, numbers, underscores, or hyphens. Your signed-in identity is used for the call; microphone and camera preferences are applied when joining.

## Structure

- `lib/ui/app_theme.dart`: shared colors, typography, form and button styling.
- `lib/ui/components.dart`: brand mark, surface card, and device preference control.
- `lib/login_page.dart`: Clerk authentication screen.
- `lib/presentation/`: responsive meeting lounge and ZEGO call screen.
- `lib/data/config/`: environment configuration.

## Checks

```sh
dart format lib test
flutter analyze
flutter test
```

Before release, verify sign-in, sign-out, camera and microphone permissions, joining from two devices, and leaving/rejoining on physical Android and iOS devices. Configure platform permissions according to the installed ZEGO UIKit version.

Environment files are bundled into client builds and do not provide secret storage. Use ZEGO server-issued tokens for production authorization rather than relying on a distributed App Sign. Never put backend secrets in the app.
