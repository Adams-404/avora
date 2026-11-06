# Music App — Product & Engineering Specification

**Status:** Planning  
**Product name:** TBD  
**Initial platform:** Android  
**Framework:** Flutter  
**Primary language:** Dart  
**Initial music provider:** Audius  
**Document purpose:** Product vision, requirements, architecture, implementation plan, and long-term roadmap.

---

## 1. Product vision

Build an independent, polished music discovery and streaming app inspired by the convenience and depth of products such as Spotify, while maintaining its own identity, design language, and product decisions.

The app should make it easy to discover music, search for tracks and artists, stream supported tracks, organize a personal library, and control playback across the app and operating system.

This is not intended to be a Spotify clone at the code, branding, or service level. It is an independently designed product that may use several legitimate music sources over time.

### Product principles

1. **Music first:** Playback must be dependable and easy to control.
2. **Discovery matters:** Help listeners find new tracks, artists, and scenes.
3. **A coherent experience:** Search, browsing, playlists, and playback should feel like parts of one product.
4. **Respect creators and rights:** Only stream, cache, or download audio where the provider's terms and applicable rights permit it.
5. **Privacy by default:** Avoid unnecessary accounts, tracking, and data collection.
6. **Extensible architecture:** Music providers should be replaceable or expandable without rewriting the player and UI.
7. **Polished, not generic:** Thoughtful typography, spacing, motion, artwork presentation, and useful empty/loading/error states.

---

## 2. Product scope and platform strategy

### Initial platform

Start with **Android using Flutter**. Android is the first delivery target so the project can be tested on real devices early.

Keep the architecture portable enough to support iOS later. Do not let Android-specific code leak unnecessarily into the domain and data layers.

### Potential future platforms

- iOS
- Desktop, if there is a clear product reason
- Web, only if the playback and provider constraints make it worthwhile

Do not promise cross-platform parity until each platform's background playback, media controls, storage, and provider policies have been validated.

---

## 3. Music sources and rights strategy

### 3.1 Audius as the initial provider

Use the official Audius API as the first streaming catalogue and discovery integration.

Investigate and implement supported capabilities such as:

- Search tracks
- Retrieve track details
- Browse trending tracks
- Browse recently uploaded or newly released tracks where supported
- Browse playlists
- Retrieve artist/profile information
- Retrieve artwork and stream URLs
- Retrieve track duration and other available metadata

Use the current official documentation as the source of truth:

- https://docs.audius.co/
- https://audius.co/

Before implementation, verify the current API authentication process, endpoints, rate limits, attribution requirements, caching rules, stream behavior, and commercial-use terms. Do not rely on old tutorials or assume that every track is available for every use.

**Important catalogue limitation:** Audius is not a complete substitute for Spotify, Apple Music, or other mainstream licensed catalogues. Popular commercial releases may be absent. “Latest” should be described accurately: latest uploads or releases available through the selected provider, not every global music release.

### 3.2 Provider abstraction

Do not couple the app directly to Audius response objects.

Define a provider interface and map provider-specific responses into app-owned models. The UI and player should consume app-owned models, not raw API JSON.

Possible provider capabilities:

- Search
- Trending
- New releases / recent uploads
- Track details
- Artist details
- Playlist details
- Stream resolution
- Artwork
- Provider attribution and source information

A provider may not support every capability. Represent unsupported capabilities explicitly instead of returning fabricated or misleading data.

### 3.3 Future provider integrations

Potential future sources may include:

- Additional independent-artist catalogues
- Royalty-free or openly licensed catalogues
- User-owned local audio files
- Official commercial music services, only where their developer terms permit the intended playback experience

Do not scrape Spotify, Apple Music, YouTube, SoundCloud, or other services. Do not extract protected streams, bypass DRM, or use undocumented endpoints to obtain audio.

Metadata access does not automatically grant audio streaming rights. A preview URL does not imply permission to provide full-length playback. Every integration must be reviewed separately.

### 3.4 Local music

Support music files already owned or stored by the user, subject to Android storage permissions and platform rules.

Local tracks should be clearly distinguished from streamed tracks. Local files can remain playable when the network is unavailable.

Do not copy, upload, or share local audio without an explicit user action.

---

## 4. Product experience and information architecture

The navigation should be simple and familiar. The final design must be original rather than a direct reproduction of Spotify.

### Main navigation

Initial proposed destinations:

1. **Home**
2. **Search**
3. **Library**

The full player is opened from the persistent mini-player. Settings and profile/preferences can be reached from the appropriate navigation or account area.

### 4.1 Home

The Home screen should be a personalized-feeling discovery surface, even before personalization exists.

Potential sections:

- Recently played
- Trending tracks
- New releases / recent uploads
- Recommended playlists
- Popular artists
- Music by genre or mood, if the provider exposes reliable classifications
- Discover something new
- Continue listening

Requirements:

- Sections should be data-driven and hide gracefully when unavailable.
- Each section should support loading, empty, and error states.
- Pull-to-refresh should refresh eligible content.
- Avoid presenting provider-wide trending data as personalized recommendations.
- Do not show fabricated editorial content.

### 4.2 Search

Search should support the provider's available search types:

- Tracks
- Artists
- Playlists
- Albums, if available through the provider

Requirements:

- Search input with clear action
- Debounced network requests
- Recent search history stored locally
- Clear search history
- Loading, no-results, and error states
- Result grouping or tabs where useful
- Selecting a result opens the relevant detail view or starts playback
- Avoid excessive API requests while the user is typing

Search history should be local by default.

### 4.3 Track and album detail

Track detail should show:

- Artwork
- Track title
- Artist
- Duration
- Provider/source
- Available actions
- Related content where supported

Album or playlist detail should show its artwork, title, creator, track list, and playback actions where the provider supports these objects.

Do not invent album relationships if the API only provides individual tracks.

### 4.4 Artist detail

Artist pages should show available profile artwork, name, description, track catalogue, playlists, and other provider-supported information.

Allow users to follow or save artists locally if provider-side following is unavailable. Clearly distinguish a local app preference from an action performed on the provider.

### 4.5 Library

The Library is the user's personal organization space.

Planned capabilities:

- Liked tracks
- User-created playlists
- Saved albums, where supported
- Saved artists
- Recently played
- Local music
- Downloaded/offline items, only where permitted
- Sorting and filtering

The Library should work without requiring an account. Use local persistence initially.

### 4.6 Playlists

Users should be able to:

- Create a playlist
- Name and rename playlists
- Add and remove tracks
- Reorder tracks
- Delete playlists
- Play a playlist
- Shuffle a playlist
- Add tracks from search, track pages, and the player

Define behavior for unavailable or deleted provider tracks. A playlist should not crash if one item cannot be resolved.

Playlist persistence should be local initially. Cloud sync can be considered later as an opt-in feature.

### 4.7 Now Playing screen

The full player is a central part of the product.

Expected elements:

- Large artwork
- Track title and artist
- Play/pause
- Previous/next
- Seek bar and elapsed/remaining time
- Shuffle
- Repeat modes
- Queue access
- Like/favorite action
- Add to playlist
- Provider attribution where required
- Useful playback error feedback

Possible later enhancements:

- Lyrics, only from a legitimate lyrics source
- Animated artwork, where available
- Audio visualization
- Sleep timer
- Playback speed, if suitable for music and supported by the audio engine
- Crossfade, if technically reliable
- Gapless playback, where supported by the source and player

### 4.8 Persistent mini-player

A mini-player should remain visible across primary browsing screens whenever a track is active.

It should show artwork, title, artist, and play/pause. Tapping it opens the full player.

It must reflect actual playback state, including buffering, paused, completed, and failed states.

### 4.9 Queue and playback behavior

Implement a real playback queue, not just independent play buttons.

Requirements:

- Add track to queue
- Play next
- View queue
- Remove queued item
- Reorder queue
- Clear queue
- Previous/next behavior
- Shuffle behavior
- Repeat off / repeat all / repeat one
- Handle end of queue
- Handle unavailable tracks without corrupting the queue
- Preserve queue and current track where practical across app restarts

Define clear behavior when a user starts a new track from a different screen.

### 4.10 Settings

Potential settings:

- Theme: system, light, dark, AMOLED
- Audio quality, only if the provider exposes selectable quality
- Streaming over mobile data preference, if meaningful
- Cache management
- Clear recent searches
- Clear recently played
- Playback behavior
- Sleep timer
- Privacy information
- Provider attribution and legal information
- App version and open-source notices

Do not display settings that do not actually work.

---

## 5. Design direction

The visual identity is not finalized. The app should be modern, minimal, distinctive, and carefully composed.

### Design goals

- Strong visual hierarchy
- Excellent album-art presentation
- Clean typography
- Consistent spacing and corner radii
- Smooth but restrained transitions
- High-quality dark theme
- Proper AMOLED-black option
- Light theme that receives equal design attention
- Responsive layouts for different Android screen sizes
- Accessible contrast and touch targets

Avoid:

- Generic template layouts
- Excessive gradients
- Unnecessary glassmorphism
- Cluttered cards and crowded screens
- Decorative controls that do nothing
- Overuse of bright accent colors
- Copying Spotify's exact layout, icons, branding, or assets

### Themes

Plan for:

1. System default
2. Light
3. Dark
4. AMOLED black

Theme colors, typography, spacing, and component styles should be centralized in a design system rather than scattered through widgets.

### Motion

Use motion to communicate state changes and improve continuity:

- Mini-player to full-player transition
- Artwork and screen transitions
- Queue changes
- Play/pause feedback
- Loading placeholders

Animations must not delay core playback controls or make the interface feel slow.

---

## 6. Technical architecture

Use a feature-oriented, layered architecture. Keep presentation, application logic, domain models, and provider/data code separated.

Suggested high-level structure:

```text
lib/
  app/
    app.dart
    router/
    theme/
    configuration/

  core/
    errors/
    network/
    storage/
    logging/
    utils/
    widgets/

  features/
    home/
      data/
      domain/
      presentation/

    search/
      data/
      domain/
      presentation/

    player/
      data/
      domain/
      presentation/

    library/
      data/
      domain/
      presentation/

    playlists/
      data/
      domain/
      presentation/

    artists/
      data/
      domain/
      presentation/

    settings/
      data/
      domain/
      presentation/

  providers/
    music_provider.dart
    audius/
      audius_api_client.dart
      audius_music_provider.dart
      models/
      mappers/

  shared/
    models/
    services/
```

This is a starting structure, not a reason to create empty folders prematurely. Add abstractions when they solve a real problem.

### 6.1 Domain models

Create app-owned models such as:

- Track
- Artist
- Album
- Playlist
- PlaylistTrack
- PlaybackQueue
- PlaybackState
- MusicSource
- SearchResult
- UserPreferences

Models should include stable identifiers and source/provider identifiers. A track ID from one provider must not be assumed to identify the same track on another provider.

### 6.2 State management

Use Riverpod for application state and dependency injection.

Keep state ownership clear:

- UI-only state stays near the widget.
- Search state belongs to the search feature.
- Library state belongs to the library feature.
- Playback state belongs to a single playback service/controller.
- Provider clients are injected rather than instantiated throughout widgets.

Avoid duplicated playback state across screens.

### 6.3 Networking

Use Dio or another maintained HTTP client.

Requirements:

- Centralized API client configuration
- Request timeouts
- Safe error mapping
- Retry only when appropriate
- Request cancellation for obsolete search queries
- Pagination support where available
- Rate-limit handling
- No API credentials committed to Git
- Avoid logging sensitive headers or tokens

The app should not assume the network is always available.

### 6.4 Audio engine

Evaluate `just_audio` for playback and `audio_service` for background audio and system media integration.

The implementation must be tested on real Android devices for:

- Background playback
- Notification controls
- Lock-screen controls
- Headset/Bluetooth controls
- Audio focus and interruptions
- Calls and other audio interruptions
- Audio becoming unavailable
- Network loss during streaming
- App process recreation
- Queue transitions

Do not consider background playback complete just because it works while the app remains visible.

### 6.5 Local persistence

Use a local database such as Drift over SQLite for structured data.

Persist:

- Playlists and playlist items
- Favorites
- Saved artists/albums
- Search history
- Recently played
- User preferences
- Playback queue and last playback position where appropriate

Use a separate cache strategy for artwork and temporary provider responses. Do not cache audio unless the provider's terms and rights explicitly permit it.

### 6.6 Artwork and image loading

Use cached network images or an equivalent maintained package.

Requirements:

- Correct image aspect ratios
- Placeholder artwork
- Error fallback
- Memory-conscious image sizing
- Cache size management
- Avoid repeated downloads during navigation

### 6.7 Secrets and API keys

Never commit private keys, access tokens, signing credentials, or production secrets.

If a provider requires a client identifier that is intended to be public, follow that provider's documented integration model. Do not pretend a value embedded in a mobile application is secret.

If a private credential is required, assess whether a small backend or secure intermediary is necessary. Do not introduce a backend without a concrete requirement.

---

## 7. Reliability, privacy, and security

### Reliability

- The app must not crash when the provider is unavailable.
- Every network-driven screen needs loading, empty, error, and retry behavior.
- Playback errors should be understandable and recoverable.
- Handle expired or invalid stream URLs by resolving them again where permitted.
- Prevent duplicate playback engines.
- Prevent overlapping requests from updating the wrong screen state.
- Handle malformed or incomplete provider responses.
- Preserve local library data when the network is unavailable.

### Privacy

Initial direction:

- No mandatory account
- No advertising SDK
- No analytics by default
- No location collection
- No contact access
- No unnecessary permissions
- Local search history and library data
- Clear controls for clearing local data

If diagnostics or analytics are considered later, make them opt-in and document exactly what is collected.

### Permissions

Request Android permissions only when a feature needs them. Follow current Android media, notification, and storage permission requirements. Avoid broad storage access if a system picker or narrower permission is sufficient.

### Security

- Validate and safely parse remote data.
- Use HTTPS endpoints.
- Avoid exposing internal errors or secrets.
- Keep dependencies maintained.
- Review third-party package permissions and licenses.
- Do not execute downloaded content as code.

---

## 8. Accessibility and localization

Plan for:

- Screen-reader labels
- Semantic controls
- Adequate contrast
- Scalable text
- Touch targets suitable for one-handed use
- Reduced-motion considerations
- Clear focus behavior
- Localization-ready strings

English is the initial interface language. Structure the app so additional languages can be added without rewriting screens.

---

## 9. Performance requirements

Prioritize:

- Fast cold start
- Responsive navigation
- No unnecessary home-screen requests
- Debounced search
- Paginated lists where possible
- Lazy loading of long catalogues
- Efficient artwork caching
- Stable playback during browsing
- Low memory usage
- No repeated initialization of the audio engine

Measure performance on a real mid-range Android device, not only an emulator or flagship phone.

---

## 10. Testing strategy

### Unit tests

Test:

- Provider response mapping
- Domain logic
- Playlist operations
- Queue operations
- Shuffle and repeat behavior
- Search debouncing and state transitions
- Persistence/repository logic
- Error mapping

### Widget tests

Test:

- Navigation
- Home sections
- Search interactions
- Track cards
- Mini-player
- Full player
- Playlist screens
- Loading, empty, and error states
- Theme switching

### Integration tests

Test full flows:

1. Launch app and load Home.
2. Search for a track.
3. Start playback.
4. Navigate to another screen while playback continues.
5. Open the full player.
6. Add a track to the queue.
7. Like a track.
8. Create a playlist and add tracks.
9. Force-close and reopen the app.
10. Test background playback and notification controls.
11. Test network loss and recovery.
12. Test a provider error or unavailable track.

### Quality gates

Before merging a feature:

- `flutter analyze` passes
- Relevant tests pass
- Formatting is clean
- No secrets are committed
- No placeholder controls are presented as working features
- Manual verification is recorded for device-specific behavior

---

## 11. Release and distribution

### Development builds

- Run on an Android emulator where useful.
- Test on a physical Android device regularly.
- Produce debug APKs for rapid testing.

### Release preparation

- App icon and splash screen
- Application ID/package name
- Versioning
- Release signing
- Build configuration
- Privacy policy if required by distribution or integrations
- Open-source license notices
- Provider attribution
- Crash-free playback verification
- Release notes

Do not commit signing keys or passwords.

### Distribution options

- Direct APK distribution for private testing
- Google Play distribution after policy, rights, privacy, and quality checks

---

## 12. Development roadmap

This roadmap describes the full product direction. It is not a promise that every feature belongs in the first release.

### Stage 0 — Product and repository setup

- Confirm product name and identity
- Create GitHub repository
- Add this specification
- Define contribution and branching conventions
- Initialize Flutter project
- Configure package identity and environments
- Add linting, formatting, and CI
- Add initial architecture and app shell

**Completion:** Project builds, runs, analyzes, and has a repeatable development workflow.

### Stage 1 — Design system and app shell

- Establish typography and spacing
- Build theme system
- Implement light, dark, and AMOLED themes
- Implement navigation
- Build reusable artwork, track row, artist tile, playlist tile, and loading components
- Add responsive behavior
- Add empty and error-state components

**Completion:** A coherent navigable app shell exists without pretending that unconnected screens are functional.

### Stage 2 — Audius integration

- Verify current API documentation and access process
- Implement provider interface
- Implement Audius client and response mapping
- Add trending content
- Add recent uploads/new releases where supported
- Add track and artist search
- Add pagination and rate-limit handling
- Add attribution and source information
- Verify streaming behavior and applicable terms

**Completion:** Real provider data appears in the app, with errors handled properly.

### Stage 3 — Playback foundation

- Integrate audio engine
- Implement one shared playback controller
- Play and pause streams
- Seek
- Previous and next
- Queue model and controls
- Shuffle and repeat
- Mini-player
- Full player
- Audio focus and interruption handling
- Background playback and system media controls

**Completion:** Playback remains stable while navigating and when the app is backgrounded, on supported devices.

### Stage 4 — Personal library

- Local database
- Like/unlike tracks
- Recently played
- Saved artists and albums where applicable
- Create, rename, and delete playlists
- Add/remove/reorder playlist tracks
- Persist user preferences
- Restore library after restart

**Completion:** The app has a useful personal library without mandatory account creation.

### Stage 5 — Discovery and refinement

- Improve Home sections
- Genre and mood discovery where supported
- Related tracks and artists where supported
- Search history
- Better playlist and artist pages
- Recommendation experiments based on local listening behavior, with privacy-conscious defaults
- Improve loading and caching

**Completion:** Discovery feels useful and the app is more than a basic streaming demo.

### Stage 6 — Local music

- Browse/import local audio using appropriate Android APIs
- Read local metadata
- Local library views
- Play local files
- Mix local and streamed items in the queue where practical
- Handle missing or moved files

**Completion:** Users can listen to their own music alongside provider content.

### Stage 7 — Advanced listening features

Potential features, prioritized after the core experience is stable:

- Sleep timer
- Lyrics from a legitimate source
- Audio visualization
- Crossfade
- Gapless playback
- Playback history insights
- Listening statistics
- Smart mixes based on local listening history
- Queue persistence and restoration improvements
- Optional home-screen widgets
- Android Auto, if feasible and policy-compliant
- Casting, only through supported and authorized integrations

### Stage 8 — Offline and downloads

This stage is conditional, not guaranteed.

- Investigate provider permissions for offline caching or downloads.
- Implement downloads only for content and providers that explicitly permit it.
- Clearly distinguish downloaded files from temporary cache.
- Provide storage controls and deletion.
- Respect any attribution, expiration, DRM, and redistribution requirements.

Never implement a workaround to download tracks where the provider does not authorize it.

### Stage 9 — Accounts and synchronization

Only add accounts if there is a real user need.

Potential capabilities:

- Optional account
- Playlist and library sync
- Restore library on a new device
- User preferences sync
- Secure authentication
- Data export and account deletion

This stage may require a backend. Evaluate operational costs, security, and privacy before choosing one.

### Stage 10 — Additional providers and platforms

- Evaluate additional legal music sources
- Add provider-specific capability support
- Improve cross-provider track identity carefully
- Evaluate official commercial-service integrations
- Prepare iOS support
- Evaluate desktop support if there is demand

Every new provider must pass a technical, legal, and product review before integration.

### Stage 11 — Public release and maintenance

- Final UX review
- Accessibility review
- Security and dependency review
- Performance testing
- Privacy and legal review
- Store listing and screenshots
- Release build and signing
- Feedback and bug triage
- Versioned release process

---

## 13. Product decisions to keep explicit

The following are not yet decided and should be resolved deliberately rather than guessed:

- Final app name
- Logo and visual identity
- Accent color
- Whether the first release includes local music
- Whether an account will ever be needed
- Whether any backend is justified
- Whether offline playback is possible under chosen providers' terms
- Whether lyrics are worth integrating
- Whether the product will remain personal/open-source or become commercial
- Which additional providers are worth supporting

Default decisions until changed:

- Android first
- Flutter and Dart
- Audius as the first provider
- Local-first library
- No mandatory account
- No ads or analytics by default
- No backend until a concrete feature requires one
- No unauthorized scraping, ripping, or DRM circumvention

---

## 14. GitHub workflow and collaboration

Use GitHub as the source of truth.

Recommended repository files:

```text
README.md
PRODUCT_SPEC.md
CONTRIBUTING.md
CHANGELOG.md
LICENSE
.gitignore
analysis_options.yaml
pubspec.yaml
.github/
  workflows/
    flutter_ci.yml
docs/
  architecture.md
  decisions/
```

### Working rules

- Work in small, reviewable changes.
- Keep the default branch buildable.
- Use feature branches for substantial work.
- Do not create a large number of speculative abstractions.
- Do not claim a feature is complete until it works and has been tested.
- Run formatting, analysis, and tests before committing.
- Explain the purpose of each change.
- Report files changed, tests run, results, and known limitations.
- Never silently discard existing project work.
- Inspect the repository before changing its architecture.
- Preserve the product specification and update it when decisions change.

### Suggested commit style

Examples:

- `chore: initialize Flutter project`
- `feat: add Audius track search`
- `feat: implement playback queue`
- `fix: recover playback after stream error`
- `test: cover playlist repository`

---

## 15. Definition of a successful product

The project should not be considered successful merely because it compiles or has attractive screens.

A successful release should:

- Discover and play real, authorized music.
- Explain where music comes from.
- Have dependable playback and background controls.
- Let users organize their own library.
- Handle poor network conditions gracefully.
- Preserve local data.
- Feel coherent and distinctive.
- Avoid misleading users about catalogue coverage or offline availability.
- Respect artists, providers, and applicable rights.
- Be maintainable by another developer.

---

## 16. First actions after the GitHub repository is created

When the repository URL is provided:

1. Inspect the repository, branches, existing files, and current project state.
2. Confirm whether it is empty or already contains code.
3. Add this specification as `PRODUCT_SPEC.md` without overwriting unrelated work.
4. Check the installed Flutter and Dart versions and available Android toolchain.
5. Initialize or repair the Flutter project as appropriate.
6. Add linting, formatting, and a basic CI workflow.
7. Build and run the initial app on an available emulator or connected device.
8. Report the exact commands, files, test results, and any blockers.
9. Begin Stage 1 only after the foundation is verified.

**Do not attempt to implement the entire roadmap in one giant change.** Build the product in complete, testable increments while keeping the long-term vision visible.
