# Play Store Screenshots Guide — PaceFlow

Capture **6.7-inch phone** screenshots (Google Play requirement for phone form factor). Target device class: **1080 × 2400 px** (e.g. Pixel 7, similar 6.7" panels).

---

## Required dimensions

| Property | Value |
|----------|-------|
| Minimum count | 2 screenshots |
| Recommended count | 6–8 |
| Aspect ratio | 9:16 (portrait recommended for fitness apps) |
| Format | PNG or JPEG (24-bit, no alpha) |
| Min long edge | 1080 px |
| Max file size | 8 MB each |

Play Console preview frame: **6.7-inch phone** — verify in **Store presence → Main store listing → Phone screenshots**.

---

## Setup on Android Emulator

1. Android Studio → **Device Manager** → Create device.
2. Select **Pixel 7** or **Pixel 7 Pro** (6.7", 1080×2400).
3. System image: API 34 or 35, Google APIs.
4. Launch emulator, install release or profile build:

```bash
flutter build apk --profile
flutter install
```

5. Disable on-screen developer indicators:
   - Settings → System → Developer options → off (or use release build).

---

## Capture methods

### Method A — Android Studio (recommended)

1. Run app on Pixel 7 emulator.
2. Click **Camera** icon in emulator toolbar → **Take screenshot**.
3. Save as `screenshot_01_active_tracking.png`, etc.

### Method B — ADB

```bash
adb exec-out screencap -p > screenshot_01.png
```

### Method C — Flutter DevTools (less ideal for store)

Use only for drafts; prefer emulator native capture for correct status bar.

---

## Recommended screenshot sequence

Capture these flows in **dark theme** (PaceFlow brand):

| # | Screen | Caption idea (optional in design overlay) |
|---|--------|-------------------------------------------|
| 1 | Sign-in / welcome | "Sign in and sync your walks" |
| 2 | Active tracking + map | "Live GPS route and stats" |
| 3 | Live stats bar close-up | "Distance, pace, calories — live" |
| 4 | Walk summary | "Beautiful walk summaries" |
| 5 | History / dashboard (when available) | "Track progress over time" |
| 6 | Achievements / streaks (when available) | "Stay motivated" |

Use **realistic demo data** (2.4 km walk, 32:15 duration, ~5:30/km pace) for consistency across shots.

---

## Post-processing (optional)

- Add minimal marketing captions in **Figma** using brand fonts (Plus Jakarta Sans) and colors (#0B0B0B background, #22C55E accent).
- Do **not** misrepresent features that are not shipped.
- Keep status bar clean (full signal, reasonable time).

Export at **1080 × 2400** without upscaling low-res captures.

---

## File naming convention

```
store_listing/screenshots/phone/
  01_sign_in.png
  02_active_tracking.png
  03_live_stats.png
  04_walk_summary.png
  05_history.png
  06_achievements.png
```

Commit PNGs only when cleared for marketing; otherwise keep local.

---

## Upload checklist

- [ ] At least 2 screenshots at 6.7" compatible resolution
- [ ] No personal real-location data you cannot publish
- [ ] Matches current app version UI
- [ ] Privacy-sensitive info blurred if using real account
- [ ] Same aspect ratio across set

---

## Tablet (optional)

7-inch: 1200 × 1920 or 1600 × 2560  
10-inch: 1600 × 2560 or 2048 × 2732

Reuse same flows; Play scales phone assets if tablet-specific shots are omitted.
