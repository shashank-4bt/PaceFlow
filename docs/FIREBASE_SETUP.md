# Firebase Setup — PaceFlow

This guide walks through Firebase, Google Sign-In, Maps, and App Check configuration for the PaceFlow Android app (`com.paceflow.paceflow`).

> **Note:** Replace placeholder values with your production project credentials. Keep API keys restricted in Google Cloud Console.

---

## 1. Create Firebase project

1. Open [Firebase Console](https://console.firebase.google.com/).
2. Click **Add project** → name it (e.g. `paceflow-prod`).
3. Disable Google Analytics during setup if you prefer to enable it later.
4. After creation, click **Add app** → **Android**.
5. Register package name: `com.paceflow.paceflow`.
6. Download `google-services.json` (optional if using FlutterFire CLI only).
7. Enable **Authentication**, **Cloud Firestore**, **Storage**, **Crashlytics**, and **Analytics** in the console.

---

## 2. Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=paceflow-prod
```

Select **Android** when prompted. This generates/updates `lib/firebase_options.dart`.

For CI or local builds without committing secrets, pass `--dart-define` values (see `lib/firebase_options.dart` header comments):

```bash
flutter run \
  --dart-define=FIREBASE_ANDROID_API_KEY=your_api_key \
  --dart-define=FIREBASE_ANDROID_APP_ID=1:123456789:android:abc123 \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=123456789 \
  --dart-define=FIREBASE_PROJECT_ID=paceflow-prod \
  --dart-define=FIREBASE_STORAGE_BUCKET=paceflow-prod.appspot.com
```

---

## 3. Deploy security rules

From the project root:

```bash
firebase login
firebase use paceflow-prod
firebase deploy --only firestore:rules,firestore:indexes,storage
```

Rules live in:

- `firebase/firestore.rules`
- `firebase/firestore.indexes.json`
- `firebase/storage.rules`

Ensure `firebase.json` points to these paths (create if missing):

```json
{
  "firestore": {
    "rules": "firebase/firestore.rules",
    "indexes": "firebase/firestore.indexes.json"
  },
  "storage": {
    "rules": "firebase/storage.rules"
  }
}
```

---

## 4. SHA-1 / SHA-256 for Google Sign-In

Google Sign-In requires your app signing certificate fingerprints in Firebase.

### Debug certificate (development)

```bash
cd android
./gradlew signingReport
```

Or PowerShell helper:

```powershell
.\scripts\setup_local.ps1 -PrintSha
```

Copy **SHA-1** and **SHA-256** from the `debug` variant.

This workspace's current debug SHA-1 (Firebase → Project settings → Android app → Add fingerprint):

```
SHA1: 77:CD:B1:A2:49:AB:19:96:D3:D0:01:12:70:F4:1C:57:BC:1E:50:02
```

### Release certificate (Play Store)

After creating your release keystore (`android/key.properties.example`):

```bash
keytool -list -v -keystore paceflow-release.jks -alias paceflow
```

Add both debug and release SHA-1/SHA-256 in:

**Firebase Console → Project settings → Your apps → Android app → Add fingerprint**

Also add the **Play App Signing** certificate SHA-1 from Google Play Console after your first upload.

---

## 5. Enable Google Sign-In

1. **Firebase Console → Authentication → Sign-in method → Google → Enable**
2. Set support email and save.
3. Ensure `google_sign_in` is configured in `pubspec.yaml` (already included).
4. No extra Android manifest entries are required beyond internet permission.

Test on a physical device with Google Play Services installed.

---

## 6. Google Maps API key

1. Open [Google Cloud Console](https://console.cloud.google.com/) linked to your Firebase project.
2. Enable **Maps SDK for Android**.
3. Create an API key under **APIs & Services → Credentials**.
4. Restrict the key:
   - **Application restrictions:** Android apps
   - Package: `com.paceflow.paceflow`
   - SHA-1: your debug and release fingerprints
   - **API restrictions:** Maps SDK for Android only
5. Set the key in `android/local.properties` (preferred; not committed):

```
MAPS_API_KEY=your_restricted_maps_sdk_key
```

Or via helper:

```powershell
.\scripts\setup_local.ps1 -MapsApiKey "your_restricted_maps_sdk_key"
```

Gradle injects it into the manifest as `${MAPS_API_KEY}`.

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

For production, prefer injecting via `--dart-define=GOOGLE_MAPS_API_KEY=...` and a build script, or use Gradle manifest placeholders.

---

## 7. Firebase App Check

App Check helps protect Firestore, Storage, and Auth from abuse.

### Android setup

1. **Firebase Console → App Check → Register app**
2. Choose **Play Integrity** for production Android.
3. For debug builds, register a **Debug provider** token:

```dart
// In main.dart before Firebase.initializeApp (debug only):
await FirebaseAppCheck.instance.activate(
  androidProvider: kDebugMode
      ? AndroidProvider.debug
      : AndroidProvider.playIntegrity,
);
```

4. Add dependency in `pubspec.yaml`:

```yaml
firebase_app_check: ^0.3.2+5
```

5. Enforce App Check in Firebase Console for Firestore and Storage after verifying clients work.

---

## 8. Crashlytics & Analytics

1. Enable Crashlytics in Firebase Console.
2. Add to `android/build.gradle.kts` (project level) if not auto-added by FlutterFire:

```kotlin
plugins {
    id("com.google.gms.google-services") version "4.4.2" apply false
    id("com.google.firebase.crashlytics") version "3.0.3" apply false
}
```

3. Run a test crash in debug to verify symbol upload (optional).

---

## 9. Verification checklist

- [ ] `flutterfire configure` completed; `firebase_options.dart` has real values
- [ ] Firestore rules deployed; owner-only access verified
- [ ] Storage rules deployed; 10 MB limit tested
- [ ] SHA-1 added for debug and release
- [ ] Google Sign-In works on device
- [ ] Map renders with restricted API key
- [ ] App Check debug token registered (dev) / Play Integrity (prod)
- [ ] Crashlytics receives test event

---

## 10. Environment separation

| Environment | Firebase project | Package suffix |
|-------------|------------------|----------------|
| Development | `paceflow-dev`   | same or `.dev` |
| Production  | `paceflow-prod`  | `com.paceflow.paceflow` |

Use separate Firebase projects and API key restrictions per environment.
