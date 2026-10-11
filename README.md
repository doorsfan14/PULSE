# PULSE

PULSE is an iOS-first social network focused on expressive conversations and user control.

## Current functionality

- Email/password account creation and sign-in using Firebase Authentication
- Unique usernames reserved in Firestore
- User profile documents
- Live chronological Firestore feed (up to the latest 50 posts)
- Text posts up to 280 characters
- Real likes stored under each post
- Profile tab and sign out
- No demo accounts, sample posts, or fabricated people

## Firebase setup

1. In Firebase Console, enable **Authentication → Sign-in method → Email/Password**.
2. Create a **Cloud Firestore** database.
3. Open Firestore **Rules**, paste the contents of [firestore.rules](firestore.rules), and publish them.
4. Keep `Firebase/GoogleService-Info.plist` in the repository; the GitHub Actions workflow copies it into the built app bundle.
5. Build through the **iOS build and IPA** workflow.

The app uses Firebase iOS SDK packages for Firebase Core, Authentication, and Firestore. The current build produces an unsigned IPA for installation through a compatible sideloading tool.

## Current limitations

- Google sign-in and passkeys are not wired up yet.
- The first milestone supports text posts; photo/video uploads, replies, follows, moderation tools, and push notifications are not implemented yet.
- Firestore reads and writes require an authenticated user.
