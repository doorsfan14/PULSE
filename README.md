# PULSE

PULSE is an iOS-first social network focused on expressive conversations and user control.

## Current functionality

- Email/password account creation and sign-in using Firebase Authentication
- Unique usernames reserved in Firestore
- User profile documents
- Live chronological Firestore feed (up to the latest 50 posts)
- Text posts up to 280 characters
- Real likes, replies, and repost records
- Flat timeline with share, delete, and per-post privacy controls
- Profile editing, bio, matching opaque avatar/banner colors, and private-account mode
- Icon-only tab bar
- Account deletion flow with recent-authentication protection
- No demo accounts, sample posts, or fabricated people

## Firebase setup

1. In Firebase Console, enable **Authentication → Sign-in method → Email/Password**.
2. Create a **Cloud Firestore** database.
3. Open Firestore **Rules**, paste the contents of [firestore.rules](firestore.rules), and publish them.
4. Keep `Firebase/GoogleService-Info.plist` in the repository; the GitHub Actions workflow copies it into the built app bundle.
5. Build through the **iOS build and IPA** workflow.

The app uses Firebase iOS SDK packages for Firebase Core, Authentication, and Firestore. The current build produces an unsigned IPA for installation through a compatible sideloading tool.

## Current limitations

- Passkeys still require a relying-party domain and server endpoints for challenge generation and verification; the iOS button alone cannot safely implement WebAuthn.
- The first milestone supports text posts; photo/video uploads, follows, moderation tools, and push notifications are not implemented yet.
- Private-account mode hides posts from other signed-in users; follower approvals are not implemented yet.
- After updating the app, publish the updated `firestore.rules` in Firebase Console for private posts, profile edits, replies, and reposts to work securely.
- Firestore reads and writes require an authenticated user.
