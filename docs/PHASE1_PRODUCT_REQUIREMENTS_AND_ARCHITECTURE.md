# PaceFlow — Phase 1: Product Requirements & Architecture

**Product:** PaceFlow  
**Tagline:** Every Step Has a Story.  
**Platform:** Android 14+ (API 34), Flutter (latest stable)  
**Version target:** 1.0.0 (Play Store launch)

---

## 1. Product Vision

PaceFlow is a premium walking-focused fitness tracker that records high-accuracy GPS walks, surfaces meaningful progress, and produces Strava-quality shareable route cards. The product prioritizes reliability, battery efficiency, privacy, and a minimal elegant UI comparable to Strava, Nike Run Club, and Apple Fitness—while remaining distinctly PaceFlow.

### Goals
- Accurate outdoor walk tracking with background GPS and automatic recovery.
- Beautiful, screenshot-ready route cards for social sharing.
- Scalable backend for 1M+ registered users and 100k+ concurrent actives.
- Production-ready Play Store release with no placeholders.

### Non-Goals (v1.0)
- Running/cycling activity types (walking only).
- Social feed / follow network.
- Live segment leaderboards.
- Apple Watch / Wear OS companion apps.
- iOS release (architecture ready; Android ships first).

---

## 2. Personas & User Journeys

### Primary Persona — Everyday Walker
Walks 3–7×/week for health. Wants simple start/stop, clear stats, and shareable maps.

### Secondary Persona — Progress Tracker
Tracks weekly distance goals, streaks, and personal records.

### Key Journeys
1. **First launch:** Onboarding → permissions → sign up → home.
2. **Record walk:** Start → background track → pause/resume → stop → save → share card.
3. **Review history:** Open walk → interactive map → stats → replay.
4. **Progress:** Dashboard weekly/monthly charts → badges → streak.
5. **Account:** Profile edit → units/theme → export → delete account.

---

## 3. Functional Requirements

### 3.1 Authentication
| ID | Requirement | Priority |
|----|-------------|----------|
| AUTH-01 | Email/password sign up & sign in | P0 |
| AUTH-02 | Google Sign-In | P0 |
| AUTH-03 | Forgot password (email reset) | P0 |
| AUTH-04 | Profile create/update (display name, avatar, bio, weight for calories) | P0 |
| AUTH-05 | Delete account (Auth + Firestore + Storage + local wipe) | P0 |
| AUTH-06 | Session persistence & secure token refresh | P0 |

### 3.2 Walk Tracking
| ID | Requirement | Priority |
|----|-------------|----------|
| TRACK-01 | Start / Pause / Resume / Stop walk | P0 |
| TRACK-02 | High-accuracy GPS with configurable filter | P0 |
| TRACK-03 | Live polyline on map | P0 |
| TRACK-04 | Distance, duration, pace, speed, calories | P0 |
| TRACK-05 | Elevation gain/loss when altitude available | P0 |
| TRACK-06 | Step count via activity recognition / sensors | P0 |
| TRACK-07 | Offline continue + local persist + sync | P0 |
| TRACK-08 | Automatic GPS recovery after signal loss | P0 |

### 3.3 Background Tracking
| ID | Requirement | Priority |
|----|-------------|----------|
| BG-01 | Foreground service with persistent notification | P0 |
| BG-02 | Survive screen off / app backgrounded | P0 |
| BG-03 | Battery-optimized location intervals | P0 |
| BG-04 | Crash recovery of in-progress walk | P0 |

### 3.4 History & Maps
| ID | Requirement | Priority |
|----|-------------|----------|
| HIST-01 | List previous walks with thumbnails | P0 |
| HIST-02 | Detail: interactive map, stats, elevation | P0 |
| HIST-03 | Map types: normal, satellite, terrain, dark | P0 |
| HIST-04 | Custom markers (start/end) & smooth polylines | P0 |
| HIST-05 | Route replay animation | P1 |

### 3.5 Statistics
| ID | Requirement | Priority |
|----|-------------|----------|
| STAT-01 | Dashboard totals (distance, walks, pace, calories, time) | P0 |
| STAT-02 | Weekly / monthly / yearly summaries | P0 |
| STAT-03 | Charts (distance over time) | P0 |
| STAT-04 | Personal records | P0 |
| STAT-05 | Streak counter & achievement badges | P0 |

### 3.6 Social Sharing
| ID | Requirement | Priority |
|----|-------------|----------|
| SHARE-01 | Aesthetic route cards (dark/light, gradients) | P0 |
| SHARE-02 | Avatar, distance, pace, time, date, calories, route | P0 |
| SHARE-03 | Export PNG: Story (1080×1920), Square (1080×1080), Wallpaper (1440×2560) | P0 |
| SHARE-04 | System share sheet | P0 |

### 3.7 Notifications
| ID | Requirement | Priority |
|----|-------------|----------|
| NOTIF-01 | Daily walk reminder (local + FCM config) | P0 |
| NOTIF-02 | Weekly summary | P1 |
| NOTIF-03 | Goal completed & milestones | P0 |

### 3.8 Settings
| ID | Requirement | Priority |
|----|-------------|----------|
| SET-01 | Units KM / Miles | P0 |
| SET-02 | Theme: system / light / dark | P0 |
| SET-03 | Notification preferences | P0 |
| SET-04 | Privacy toggles | P0 |
| SET-05 | Export data (JSON) | P0 |
| SET-06 | Delete account | P0 |

### 3.9 Offline & Sync
| ID | Requirement | Priority |
|----|-------------|----------|
| OFF-01 | Local Drift/SQLite store for walks & points | P0 |
| OFF-02 | Queue writes; sync when online | P0 |
| OFF-03 | Conflict resolution: last-write-wins with server timestamps | P0 |

---

## 4. Non-Functional Requirements

| Area | Target |
|------|--------|
| Crash-free | ≥ 99.5% sessions |
| Cold start | < 2.5s on mid-range Android |
| Tracking FPS UI | 60 FPS map/stats updates |
| GPS interval | 1–3s active; adaptive when paused |
| Battery | ≤ 8%/hour active tracking (typical mid-range) |
| Scale | 1M+ users; 100k concurrent; batched Firestore writes |
| Security | Firebase Auth, Security Rules, encrypted local prefs |
| Accessibility | TalkBack labels, contrast, large text |

---

## 5. Architecture Overview

### 5.1 Clean Architecture Layers

```
┌─────────────────────────────────────────────────────────┐
│ Presentation (UI + Riverpod Controllers/Notifiers)      │
├─────────────────────────────────────────────────────────┤
│ Domain (Entities, Use Cases, Repository Interfaces)     │
├─────────────────────────────────────────────────────────┤
│ Data (Repos, DataSources, Mappers, Local DB)         │
├─────────────────────────────────────────────────────────┤
│ Platform (GPS, Sensors, Background, Maps, Sharing)      │
└─────────────────────────────────────────────────────────┘
```

### 5.2 Module / Feature Map

```
lib/
  main.dart
  app/                    # MaterialApp, theme, router
  core/                   # errors, network, di, constants, utils, logging
  features/
    auth/
    onboarding/
    tracking/
    history/
    statistics/
    sharing/
    profile/
    settings/
    notifications/
  shared/
    widgets/
    models/               # cross-cutting DTOs if needed
```

Each feature: `data/`, `domain/`, `presentation/`.

### 5.3 State Management
- **Riverpod 2.x** with code generation (`@riverpod`).
- AsyncValue for remote/local loading states.
- Dedicated `WalkSessionNotifier` for live tracking (high-frequency updates isolated from dashboard).

### 5.4 Dependency Injection
- Riverpod providers as DI graph.
- Interfaces in domain; implementations overridden in bootstrap.

### 5.5 Data Flow
1. UI → Notifier → Use Case → Repository.
2. Repository: local first for tracking writes; remote sync via SyncEngine.
3. Firestore: users, walks metadata, aggregates; Storage: avatars & share images (optional).
4. GPS points: local primary; upload in compressed batches after walk ends.

### 5.6 Tracking Engine Design
- `LocationService` wraps `geolocator` + Android Fused Location.
- `GpsFilter` rejects low accuracy / jumps (Haversine + speed sanity).
- `MetricsEngine` computes distance, pace, calories (MET-based with user weight), elevation.
- `StepCounterService` uses `pedometer` / Sensor.TYPE_STEP_COUNTER.
- `BackgroundLocationManager` starts foreground service (`flutter_foreground_task` / native).
- `WalkPersistence` writes points to Drift every N points or 5s.
- `GpsRecovery` resumes last unfinished session on cold start.

### 5.7 Sync Strategy (Scale)
- Walk document: summary fields only (~1 KB).
- Points: subcollection in chunks of 500, or gzipped JSON in Storage for long walks.
- Aggregates: Cloud Function / client-side incremental counters with transactions.
- Indexes: `userId + startedAt desc`, `userId + distance`, date ranges.
- Avoid per-point realtime Firestore writes during walk.

### 5.8 Security Architecture
- Firebase App Check (Play Integrity) recommended for production.
- Firestore rules: `request.auth.uid == userId`.
- Storage rules: user-scoped paths.
- Local: `flutter_secure_storage` for tokens/secrets; Drift for walk data.
- Input validation on all forms; rate-limit auth via Firebase defaults + client debounce.
- API keys restricted by package name + SHA-1/256 in Google Cloud Console.

### 5.9 Analytics & Crash Reporting
- Firebase Analytics: screen views, walk_started, walk_completed, share_exported.
- Firebase Crashlytics: non-fatal for GPS failures, sync errors.

---

## 6. Tech Stack (Locked)

| Concern | Choice |
|---------|--------|
| Framework | Flutter stable |
| State | flutter_riverpod + riverpod_annotation |
| Navigation | go_router |
| Backend | Firebase Auth, Firestore, Storage, FCM, Analytics, Crashlytics |
| Maps | google_maps_flutter |
| Location | geolocator + permission_handler |
| Background | flutter_foreground_task |
| Local DB | drift (SQLite) |
| Secure storage | flutter_secure_storage |
| Charts | fl_chart |
| Images | cached_network_image, image_picker |
| Share export | widgets_to_image / RepaintBoundary + share_plus + path_provider |
| DI | Riverpod |
| Logging | talker / custom AppLogger |
| Lint | flutter_lints / very_good_analysis |

---

## 7. Brand & UI System

| Token | Value |
|-------|-------|
| Primary Black | `#0B0B0B` |
| Emerald | `#22C55E` |
| White | `#FFFFFF` |
| Electric Blue | `#3B82F6` |
| Sunset Orange | `#F97316` |
| Purple Gradient | `#8B5CF6` → `#A855F7` |

- Material 3, dynamic color optional (seed: Emerald).
- Glassmorphism on overlays (blur + translucency).
- Typography: Plus Jakarta Sans (UI) + Space Grotesk (display metrics).
- Motion: 200–350ms ease-out; shared element where appropriate.
- Dark default for tracking screens; system-aware elsewhere.

---

## 8. Screen Map

1. Splash  
2. Onboarding (3 pages)  
3. Auth (Sign In / Sign Up / Forgot)  
4. Home / Dashboard  
5. Active Tracking  
6. Walk Summary (post-stop)  
7. History List  
8. Walk Detail + Replay  
9. Share Card Studio  
10. Statistics  
11. Profile  
12. Settings  
13. Privacy / Legal (in-app WebView or markdown)

---

## 9. Permissions (Android)

- `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`
- `ACCESS_BACKGROUND_LOCATION` (Android 10+)
- `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_LOCATION`
- `POST_NOTIFICATIONS` (Android 13+)
- `ACTIVITY_RECOGNITION` (steps)
- `INTERNET`, `ACCESS_NETWORK_STATE`
- `WAKE_LOCK`
- `RECEIVE_BOOT_COMPLETED` (resume unfinished walk reminder)

---

## 10. Release & Compliance Checklist (Preview)

- Privacy Policy & Terms  
- Data safety form (location, health-ish metrics, personal info)  
- Adaptive icon + splash + feature graphic  
- R8/ProGuard keep rules for Firebase/Maps  
- App signing (Play App Signing)  
- Target SDK 35 / min SDK 26  

---

## 11. Success Metrics (Launch)

- Walk completion rate > 90% of starts  
- Share export rate > 15% of completed walks  
- D7 retention > 25%  
- p95 location accuracy < 15m outdoors  

---

## 12. Phase Gate

Phase 1 is complete when this document is accepted as the source of truth for subsequent phases. Phase 2 defines the concrete Firestore + Drift schemas derived from these requirements.
