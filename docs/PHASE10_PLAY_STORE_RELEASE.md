# Phase 10 — Google Play Store Release

Production release checklist for PaceFlow Android (`com.paceflow.paceflow`).

---

## Prerequisites

- [ ] Firebase production project configured (`docs/FIREBASE_SETUP.md`)
- [ ] Firestore rules and indexes deployed
- [ ] Google Maps API key restricted to release SHA-1
- [ ] Privacy policy and terms published at public URLs
- [ ] Play Console developer account active ($25 one-time fee paid)
- [ ] Content rating questionnaire completed
- [ ] Data safety form completed (`store_listing/DATA_SAFETY.md`)

---

## 1. Create release keystore

```bash
keytool -genkey -v \
  -keystore android/paceflow-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias paceflow
```

Store the keystore and passwords in a **password manager** and secure backup. Loss prevents app updates.

---

## 2. Configure signing

```bash
cp android/key.properties.example android/key.properties
```

Edit `android/key.properties`:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=paceflow
storeFile=paceflow-release.jks
```

Verify `android/key.properties` and `*.jks` are in `.gitignore` (never commit).

`android/app/build.gradle.kts` reads this file for the `release` signing config.

---

## 3. Register SHA-1 fingerprints

```bash
cd android
./gradlew signingReport
```

Add **release** SHA-1 and SHA-256 to:

1. Firebase Console → Project settings → Android app
2. Google Cloud Console → Maps API key restrictions
3. Google Play App Signing (after first upload — use Play-provided signing cert)

---

## 4. Build release AAB

From project root:

```bash
flutter clean
flutter pub get
flutter build appbundle --release \
  --dart-define=FIREBASE_ANDROID_API_KEY=your_prod_key \
  --dart-define=FIREBASE_ANDROID_APP_ID=your_prod_app_id \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=your_sender_id \
  --dart-define=FIREBASE_PROJECT_ID=paceflow-prod \
  --dart-define=FIREBASE_STORAGE_BUCKET=paceflow-prod.appspot.com
```

Output:

```
build/app/outputs/bundle/release/app-release.aab
```

### Optional: verify APK from bundle (local testing)

```bash
bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab \
  --output=paceflow.apks --mode=universal
```

---

## 5. Pre-upload QA on release build

```bash
flutter install --release
```

Test matrix:

- [ ] Cold start and splash (#0B0B0B)
- [ ] Sign up / sign in / Google Sign-In
- [ ] Location permission flows (foreground + background)
- [ ] Start walk → background 5 min → resume
- [ ] Map renders with production Maps key
- [ ] Stop walk → summary → sync when online
- [ ] ProGuard: no crash on auth, maps, Firestore
- [ ] Notifications (if enabled)

---

## 6. Play Console upload

1. **Play Console → Create app → PaceFlow**
2. **Release → Production → Create new release**
3. Upload `app-release.aab`
4. Enable **Google Play App Signing** (recommended)
5. Complete store listing (`store_listing/PLAY_STORE_LISTING.md`)
6. Upload feature graphic and screenshots
7. Set countries, pricing (free), content rating, data safety

---

## 7. Release checklist

| Item | Status |
|------|--------|
| versionName / versionCode bumped in `pubspec.yaml` | |
| Release notes written | |
| ProGuard rules verified | |
| Crashlytics receiving events | |
| App Check enforced (production) | |
| Privacy policy URL live | |
| Account deletion works | |
| Internal testing track passed | |
| Closed testing (optional) passed | |

---

## 8. Version bumps

Edit `pubspec.yaml`:

```yaml
version: 1.0.1+2
```

- `1.0.1` → `versionName` (user-visible)
- `2` → `versionCode` (must increase every Play upload)

---

## 9. Post-release monitoring

- Firebase Crashlytics — watch crash-free users > 99%
- Analytics — sign-up funnel, walk completion rate
- Play Console vitals — ANRs, startup time
- Review user feedback first 48 hours

---

## 10. Rollback

Play Console allows halting a rollout. Keep previous AAB artifact tagged in CI for emergency redeploy.

---

## CI command reference (future)

```yaml
# Example GitHub Actions step
- run: flutter build appbundle --release
  env:
    FIREBASE_ANDROID_API_KEY: ${{ secrets.FIREBASE_ANDROID_API_KEY }}
```

Store all `--dart-define` values as CI secrets.

---

## Related documents

- `docs/FIREBASE_SETUP.md`
- `store_listing/PLAY_STORE_LISTING.md`
- `store_listing/DATA_SAFETY.md`
- `android/key.properties.example`
- `android/app/proguard-rules.pro`

---

*Phase 10 complete when production AAB is uploaded and rollout begins.*
