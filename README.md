# AVORA

AVORA is an independent music discovery and listening app, built with Flutter. The initial target is Android, with an architecture intended to remain portable.

The product and engineering direction is documented in [the product specification](Music_App_Product_and_Engineering_Spec.md). The initial visual principles are in [docs/design-direction.md](docs/design-direction.md).

## Project status

Early foundation work. The repository currently contains the initial Flutter application source; Android/iOS platform scaffolding and feature implementation are being developed incrementally. Do not treat the current shell as a finished MVP.

## Prerequisites

- Flutter stable SDK (Dart 3.6 or newer)
- Android SDK and an emulator or physical Android device

## Setup

```bash
flutter create . --platforms=android,ios
flutter pub get
flutter analyze
flutter test
flutter run
```

If platform folders already exist, inspect them before regenerating. Never overwrite signing configuration or local Android SDK settings.

## Product principles

- Music discovery and playback first.
- Local-first library; no mandatory account.
- Audius is the first planned catalogue provider, subject to current API terms and capabilities.
- No unauthorized scraping, stream extraction or DRM circumvention.
- No audio downloads unless a provider explicitly permits them.
- No ads or analytics by default.

## Development

Run formatting, analysis and tests before committing:

```bash
dart format .
flutter analyze
flutter test
```

See GitHub Issues for the staged implementation plan.
