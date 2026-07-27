# PaceFlow — Phase 3: Project Structure

This document describes the `lib/` directory layout, conventions, and how feature modules connect.

---

## Overview

PaceFlow uses **feature-first clean architecture** with shared **core** utilities and an **app** layer for theming and routing (routing to be wired in a later phase).

```
lib/
├── main.dart                 # App entry (bootstrap, Firebase init)
├── firebase_options.dart     # FlutterFire generated / dart-define config
├── app/                      # Global UI shell
├── core/                     # Cross-cutting infrastructure
└── features/                 # Vertical feature modules
    ├── auth/
    ├── tracking/
    └── statistics/
```

---

## `app/` — Theming & layout tokens

| Path | Purpose |
|------|---------|
| `app/theme/app_colors.dart` | Brand color tokens (emerald, primary black) |
| `app/theme/app_typography.dart` | Plus Jakarta Sans text styles |
| `app/theme/app_spacings.dart` | Spacing, radii, insets |
| `app/theme/app_theme.dart` | Material 3 light/dark `ThemeData` |

---

## `core/` — Shared infrastructure

| Path | Purpose |
|------|---------|
| `core/constants/app_constants.dart` | GPS intervals, validation limits, MET table |
| `core/constants/storage_keys.dart` | Secure storage / prefs keys |
| `core/database/app_database.dart` | Drift schema (walks, sync queue, settings) |
| `core/database/database_provider.dart` | Riverpod provider for DB |
| `core/di/providers.dart` | Firebase SDK + auth use-case providers |
| `core/errors/` | `Failure`, `AppException`, `ErrorHandler` |
| `core/logging/app_logger.dart` | Structured logging |
| `core/network/connectivity_service.dart` | Online/offline detection |
| `core/services/analytics_service.dart` | Firebase Analytics wrapper |
| `core/services/crash_reporting_service.dart` | Crashlytics wrapper |
| `core/services/secure_storage_service.dart` | Encrypted key-value storage |
| `core/utils/geo_utils.dart` | Haversine, polyline encode/decode, bounds |
| `core/utils/formatters.dart` | Distance, pace, duration display |
| `core/utils/validators.dart` | Form validation |
| `core/utils/result.dart` | `Result<T>` for use-case boundaries |

---

## `features/auth/` — Authentication & profile

```
auth/
├── data/
│   ├── datasources/auth_remote_datasource.dart
│   ├── models/user_profile_model.dart
│   └── repositories/auth_repository_impl.dart
├── domain/
│   ├── entities/user_profile.dart
│   ├── repositories/auth_repository.dart
│   └── usecases/          # signIn, signUp, signInGoogle, etc.
└── presentation/
    ├── controllers/auth_controller.dart
    ├── pages/             # sign_in, sign_up, forgot_password
    └── widgets/           # auth_scaffold, auth_text_field, social_auth_button
```

**Flow:** UI → `AuthController` → use case → repository → Firebase Auth + Firestore `users/{uid}`.

---

## `features/tracking/` — GPS walk tracking

```
tracking/
├── data/
│   ├── datasources/       # location, steps, walk local/remote
│   ├── models/walk_dto.dart
│   ├── providers/tracking_providers.dart
│   ├── repositories/tracking_repository_impl.dart
│   └── services/          # background_tracking, sync_engine, gps_recovery
├── domain/
│   ├── entities/          # geo_point, walk_session, walk_metrics
│   ├── repositories/tracking_repository.dart
│   ├── services/          # gps_filter, metrics_engine, polyline_encoder
│   └── usecases/          # start, pause, resume, stop, discard, recover
└── presentation/
    ├── controllers/walk_session_controller.dart
    ├── pages/             # active_tracking, walk_summary
    └── widgets/           # route_map, live_stats_bar, stat_chip, tracking_controls
```

**Flow:** Location stream → `GpsFilter` → `MetricsEngine` → local Drift persist → `SyncEngine` → Firestore/Storage.

---

## `features/statistics/` — Aggregates & badges

```
statistics/
└── domain/
    └── services/badge_evaluator.dart   # Achievement unlock logic
```

Future phases add dashboard UI, charts (`fl_chart`), and Firestore `stats/` sync.

---

## Dependency direction

```
presentation → domain ← data
     ↓            ↓
   core (utils, errors, constants)
```

- **Domain** must not import Flutter or Firebase SDKs.
- **Data** implements domain repository interfaces.
- **Presentation** uses Riverpod providers and domain use cases/controllers.

---

## State management

- **Riverpod 2** with `NotifierProvider` for controllers (`AuthController`, `WalkSessionController`).
- Code-generated providers planned via `riverpod_annotation` where scale warrants it.

---

## Assets

```
assets/
├── images/
├── icons/
├── map_styles/
└── legal/              # privacy_policy.md, terms_and_conditions.md
```

Referenced in `pubspec.yaml`.

---

## Platform folders

| Folder | Role |
|--------|------|
| `android/` | Gradle config, manifest, ProGuard, signing |
| `firebase/` | Firestore/Storage rules and indexes |
| `docs/` | Phase docs, Firebase setup, release guides |
| `store_listing/` | Play Store copy and asset specs |
| `test/` | Unit, widget, performance tests |
| `integration_test/` | Device smoke tests |

---

## Naming conventions

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Providers: `*Provider` suffix
- Use cases: verb phrases (`StartWalk`, `SignIn`)
- DTOs: `*Dto` or `*Model` in data layer only

---

## Phase gate

Phase 3 is complete when:

- [x] Directory structure matches this document
- [x] Core utils and domain services are test-covered
- [x] Firebase rules and Android release scaffolding exist
- [ ] `main.dart` bootstraps Firebase + `GoRouter` (next phase)
- [ ] Dashboard/statistics UI (next phase)
