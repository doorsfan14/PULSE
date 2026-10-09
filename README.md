# PULSE

PULSE is an iOS-first social network focused on expressive conversations and user control.

**Status:** Intro and authentication UI prototype. Account registration, sign-in, and passkey authentication are not connected to a backend yet.

## Current prototype
- Welcome screen with Create Account and Sign In paths
- Account creation form with full name, username, email, password, and password confirmation
- Basic form validation and matching-password checks
- Show/hide password control
- Passkey entry points on account creation and sign-in screens
- SwiftUI with no third-party dependencies
- No demo account or sample posts

## Build
Open `PULSE.xcodeproj` in Xcode and run the **PULSE** scheme on an iOS Simulator (iOS 17 or later).

## Important
This is not a production-ready social network. Authentication is currently UI-only. Real passkeys require server-generated challenges, a registered relying-party domain, and server-side credential verification.
