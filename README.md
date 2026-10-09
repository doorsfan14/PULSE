# PULSE

PULSE is an iOS-first social network focused on expressive conversations, user control, and safety by design.

**Status:** Early UI prototype. Authentication, backend services, media uploads, messaging delivery, and moderation services are not implemented. Sample posts are local demo data.

## Current prototype
- Five-tab navigation: Home, Explore, Create, Activity, and Profile
- For You and Following feed switcher
- Sample post cards with like/reply/repost actions for UI exploration
- Light/dark appearance follows the system
- SwiftUI, with no third-party dependencies

## Product principles
- Profanity alone is not a violation; moderation considers context and target.
- Potential harassment is flagged for context-aware review, not automatic account punishment from a keyword alone.
- Suspected harmful message requests should be hidden by default, with recipient choice to reveal them.
- Sensitive-topic notices should offer supportive options without treating a mention as misconduct.
- No location-sharing feature at launch.
- Profile privacy, blocking, reporting, and accessibility are core product requirements.

## Build
Open `PULSE.xcodeproj` in Xcode and run the **PULSE** scheme on an iOS Simulator (iOS 17 or later).

## Important
This prototype is not a production-ready social network. Do not use it with real personal data. Before release, PULSE needs a reviewed privacy policy, age-eligibility and jurisdiction review, backend security, moderation operations, account/reporting flows, and accessibility testing.
