# PaceFlow — Resume Checkpoint

**Last updated:** 2026-07-27  
**Status:** Debug APK **installed & launched** on Pixel_8_Pro emulator. Next: real Firebase + Maps keys.

## Verified this session

- `flutter analyze` → **No issues found**
- Emulator `Pixel_8_Pro` / `emulator-5554` → online
- Installed `build\app\outputs\flutter-apk\app-debug.apk` → **Success**
- Started `com.paceflow.paceflow/.MainActivity`
- Debug SHA-1: `77:CD:B1:A2:49:AB:19:96:D3:D0:01:12:70:F4:1C:57:BC:1E:50:02`
- `MAPS_API_KEY` placeholder in `android/local.properties`
- Helper script: `scripts/setup_local.ps1`

## Blocked on your credentials

Auth/maps/sync need real project keys:

1. **Firebase**
   ```powershell
   .\scripts\setup_local.ps1 -FlutterFire -PrintSha
   ```
   Add the SHA-1 above in Firebase Console. Deploy rules:
   ```bash
   firebase deploy --only firestore:rules,firestore:indexes,storage
   ```

2. **Maps**
   ```powershell
   .\scripts\setup_local.ps1 -MapsApiKey "YOUR_REAL_KEY"
   ```
   Then rebuild/reinstall:
   ```powershell
   flutter build apk --debug
   adb install -r build\app\outputs\flutter-apk\app-debug.apk
   ```

3. Without Firebase configured, app still launches but auth/cloud features will not work (startup is resilient).

## Commands cheat sheet

```powershell
$env:PATH = "C:\flutter\bin;C:\AndroidSDK\platform-tools;$env:PATH"
$env:ANDROID_HOME = "C:\AndroidSDK"
cd D:\Cursor\PaceFlow

flutter emulators --launch Pixel_8_Pro
flutter run -d emulator-5554
# or install existing APK:
adb install -r build\app\outputs\flutter-apk\app-debug.apk
adb shell am start -n com.paceflow.paceflow/.MainActivity
```

## Say next

- “wire Firebase” (provide project id / run flutterfire with you)
- “set maps key …”
- “release AAB”
