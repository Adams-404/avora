# AVORA

AVORA is an independent music discovery and listening app, built with Flutter. The initial target is Android, with an architecture intended to remain portable.

The product and engineering direction is documented in [the product specification](Music_App_Product_and_Engineering_Spec.md). The initial visual principles are in [docs/design-direction.md](docs/design-direction.md).

## Project status

Stage 1 of the roadmap: a navigable app shell. The theme system (light, dark,
AMOLED, system, persisted locally), responsive navigation for narrow and wide
windows, page chrome, and honest empty states are in place.

Not implemented yet: any music provider, playback, library storage or search.
Screens state this rather than showing sample content, so do not treat the
current shell as a finished MVP.

## Prerequisites

- Flutter stable SDK (Dart 3.6 or newer)
- Android SDK and an emulator or physical Android device

## Setup

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

If platform folders already exist, inspect them before regenerating. Never overwrite signing configuration or local Android SDK settings.

## Previewing in a browser

The `web/` target exists for fast UI review while Android work continues:

```bash
flutter run -d chrome
```

To use a specific Chromium browser, point `CHROME_EXECUTABLE` at it, for
example `CHROME_EXECUTABLE=/usr/bin/brave-browser flutter run -d chrome`.
Use `flutter run -d web-server --web-port=8080` when a window should not be
launched automatically. Browser playback is not a supported product target.

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
