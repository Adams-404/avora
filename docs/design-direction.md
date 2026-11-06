# AVORA Visual Direction

**Status:** Initial design direction  
**Product:** AVORA  
**Platform:** Android first  
**Principle:** Original, artwork-led listening experience. References inform design decisions; they are not templates to reproduce.

## Product character

AVORA should feel calm, confident, tactile and considered. The interface should give music and artwork room to breathe. It should be recognizably AVORA through its typography, spacing, navigation, surfaces and interaction details rather than relying on a loud gradient or a copied streaming-app layout.

The visual language should balance three priorities:

1. **Music is the visual focus.** Artwork should be large enough to matter, with reliable fallbacks and consistent presentation.
2. **Controls stay obvious.** A beautiful player is not useful if listeners have to guess where seek, pause or queue controls went.
3. **The interface stays quiet.** Use hierarchy, alignment, typography and negative space instead of decorative cards, borders and effects.

## Reference study

### TIDAL: artwork-led Now Playing

Reference: [TIDAL player redesign coverage, May 2026](https://piunikaweb.com/2026/05/06/tidal-ios-music-player-redesign-rolling-out/)

Useful observations:
- Large, square artwork can create a more immersive listening surface.
- Artwork-derived atmosphere can make each track feel distinct.
- Fluid transitions help connect the compact and expanded player.

AVORA decisions:
- Give artwork a prominent role in Now Playing.
- Explore subtle artwork-aware surface treatments only if they preserve text contrast and do not require heavy gradients.
- Keep essential playback controls visible and discoverable; do not hide core controls behind artwork taps.

### Apple Music for Android: navigation and artist presentation

Reference: [Apple Music 7.0 Android redesign, 30 October 2026](https://9to5google.com/2026/10/30/apple-music-7-0-redesign/)

Useful observations:
- Edge-to-edge layouts and carefully handled bottom navigation can make content feel more spacious.
- Artist pages benefit from a strong identity area and clear primary actions.
- Settings work better when grouped by purpose.

AVORA decisions:
- Use edge-to-edge Android layout while respecting system insets.
- Give artist and playlist pages a clear visual header and a prominent play action.
- Keep navigation compact and predictable. Do not adopt translucent floating bars just because they are fashionable; use them only if they improve legibility and ergonomics.

### Independent mobile player composition

Reference: [Made Good Designs - mobile music player screen](https://madegooddesigns.com/inspiration/ui/music-player-mobile-playful-0e6f9aac107f)

Useful observations:
- A player screen needs a coherent relationship between artwork, track identity, timeline, transport and secondary actions.
- A complete listening screen should make queue and supporting information reachable without crowding the primary controls.

AVORA decisions:
- Establish a clear primary-to-secondary action hierarchy.
- Keep seek and transport controls easy to reach.
- Treat lyrics, credits and artist-support content as optional future capabilities, not placeholders.

## Visual principles

### Typography
- Choose a highly legible modern type family with a distinctive but restrained display style.
- Use a small, deliberate type scale with clear title, section, body and metadata roles.
- Avoid oversized headings that compete with album artwork.
- Use tabular numerals for time and duration where appropriate.

### Color and themes
- Define semantic color tokens rather than hardcoding values in widgets.
- Support System, Light, Dark and AMOLED modes.
- Light mode must be designed intentionally, not treated as an afterthought.
- Dark mode should use layered near-black surfaces where hierarchy benefits from them.
- AMOLED mode should use true black for major backgrounds while preserving visible separation for controls and surfaces.
- Keep accent color use restrained and purposeful. Final brand accent remains an open decision.

### Layout and surfaces
- Use consistent spacing and alignment.
- Prefer open layouts and artwork over piles of cards.
- Use corner radii consistently; avoid rounding every element by default.
- Avoid gradients, glassmorphism, glow effects and ornamental shadows unless a tested interaction genuinely benefits.
- Keep touch targets comfortable and reachable.

### Motion
- Motion should explain state changes: opening Now Playing, changing tracks, updating queue and toggling playback.
- Keep transitions short and interruptible.
- Never delay a core playback action for an animation.
- Respect reduced-motion preferences where possible.

### Accessibility
- Maintain readable contrast across all themes.
- Provide semantic labels for icon-only controls.
- Support text scaling without clipping.
- Keep primary player actions discoverable and sufficiently large.
- Do not communicate playback state through color alone.

## Initial screen direction

### Home
A calm discovery surface with a concise greeting/brand anchor, a small number of high-quality content sections, strong artwork and clear section labels. Do not simulate personalization: label provider-wide trending and recent uploads accurately.

### Search
A focused search surface. The input should be immediately discoverable, results should be easy to scan, and recent searches should not overwhelm the page.

### Library
A personal collection rather than a settings dump. Liked tracks and playlists should be easy to reach. Empty states should explain what users can do next.

### Now Playing
The signature AVORA screen. Large artwork, track and artist identity, a readable progress timeline and obvious transport controls. Queue, repeat, shuffle and like actions should be accessible without visual clutter. The mini-player should be a dependable persistent control surface, not merely a decorative strip.

## Open design decisions

These decisions should be tested in the actual app before being treated as final:
- Final brand typeface and accent color.
- Whether Now Playing uses a fully neutral background or subtle artwork-aware surfaces.
- Bottom navigation shape and mini-player placement.
- Final artwork corner treatment.
- Motion curves and durations.

## Implementation guardrails

- Do not copy another service's screen pixel-for-pixel.
- Do not use copyrighted brand assets or screenshots as product assets.
- Do not add fake content to make a screen look populated.
- Do not ship controls that do nothing.
- Validate designs on a physical Android phone and at multiple text scales.
