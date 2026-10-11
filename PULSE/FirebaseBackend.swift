import Foundation
import FirebaseAuth
import FirebaseFirestore

enum PULSEBackendError: LocalizedError {
    case usernameTaken

    var errorDescription: String? {
        switch self {
        case .usernameTaken:
            return "That username is already taken. Please choose another one."
        }
    }
}

final class PULSEBackend {
    static let shared = PULSEBackend()

    let db = Firestore.firestore()
    private let auth = Auth.auth()

    private init() {}

    func createAccount(name: String, username: String, email: String, password: String) async throws {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameKey = cleanUsername.lowercased()
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        let result = try await auth.createUser(withEmail: cleanEmail, password: password)
        let user = result.user

        do {
            let usernameRef = db.collection("usernames").document(usernameKey)
            let existing = try await usernameRef.getDocument()
            guard !existing.exists else { throw PULSEBackendError.usernameTaken }

            let batch = db.batch()
            batch.setData([
                "uid": user.uid,
                "createdAt": FieldValue.serverTimestamp()
            ], forDocument: usernameRef)
            batch.setData([
                "displayName": cleanName,
                "username": cleanUsername,
                "usernameLowercase": usernameKey,
                "createdAt": FieldValue.serverTimestamp()
            ], forDocument: db.collection("users").document(user.uid))
            try await batch.commit()

            let profileChange = user.createProfileChangeRequest()
            profileChange.displayName = cleanName
            try await profileChange.commitChanges()
        } catch {
            try? await user.delete()
            throw error
        }
    }

    func signIn(email: String, password: String) async throws {
        try await auth.signIn(
            withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(),
            password: password
        )
    }

    func signOut() throws {
        try auth.signOut()
    }
}
