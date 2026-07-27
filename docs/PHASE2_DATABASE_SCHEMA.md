# PaceFlow — Phase 2: Database Schema

**Sources of truth:** Firestore (cloud) + Drift/SQLite (local, offline-first)  
**Sync model:** Local-first during tracking; batch sync after walk completion and on connectivity restore.

---

## 1. Firestore Collections

### 1.1 `users/{userId}`

| Field | Type | Notes |
|-------|------|-------|
| uid | string | = auth uid |
| email | string | |
| displayName | string | |
| photoUrl | string? | Storage or Google |
| bio | string? | max 280 |
| weightKg | number | default 70; used for calories |
| heightCm | number? | |
| units | string | `km` \| `mi` |
| themeMode | string | `system` \| `light` \| `dark` |
| privacy | map | see below |
| notificationPrefs | map | see below |
| fcmTokens | array\<string\> | device tokens |
| onboardingCompleted | bool | |
| createdAt | timestamp | server |
| updatedAt | timestamp | server |
| lastActiveAt | timestamp | |
| isDeleted | bool | soft-delete flag during purge |

**privacy**
```
{
  shareStatsPublicly: bool,   // default false
  showOnLeaderboards: bool,   // reserved false in v1
  storePreciseLocation: bool  // if false, strip points on upload (summary only)
}
```

**notificationPrefs**
```
{
  dailyReminder: bool,
  dailyReminderHour: int,     // 0-23 local
  dailyReminderMinute: int,
  weeklySummary: bool,
  goalCompleted: bool,
  milestones: bool
}
```

### 1.2 `users/{userId}/walks/{walkId}`

Summary document only (no dense point arrays).

| Field | Type | Notes |
|-------|------|-------|
| id | string | uuid v4 |
| userId | string | |
| title | string? | optional user title |
| status | string | `completed` \| `discarded` |
| startedAt | timestamp | |
| endedAt | timestamp | |
| durationMs | number | active time excluding pause |
| pausedDurationMs | number | |
| distanceMeters | number | |
| avgPaceSecPerKm | number | |
| avgSpeedMps | number | |
| maxSpeedMps | number | |
| caloriesKcal | number | |
| steps | number | |
| elevationGainM | number | |
| elevationLossM | number | |
| startLat | number | |
| startLng | number | |
| endLat | number | |
| endLng | number | |
| bounds | map | `{ minLat, maxLat, minLng, maxLng }` |
| polylineEncoded | string | Google encoded polyline (downsampled) |
| pointCount | number | |
| pointsStoragePath | string? | if points stored in Storage |
| mapSnapshotUrl | string? | optional |
| sourceDevice | string | model / os |
| appVersion | string | |
| syncVersion | number | incremental |
| createdAt | timestamp | |
| updatedAt | timestamp | |
| localId | string | Drift primary key for idempotent sync |

### 1.3 `users/{userId}/walks/{walkId}/pointChunks/{chunkId}`

Optional chunked points for long walks when not using Storage blob.

| Field | Type | Notes |
|-------|------|-------|
| chunkIndex | number | 0-based |
| points | array\<map\> | max 500 |
| count | number | |

**Point map**
```
{
  t: number,   // epoch ms
  lat: number,
  lng: number,
  alt: number?,
  acc: number?, // accuracy meters
  spd: number?, // m/s
  bearing: number?
}
```

### 1.4 `users/{userId}/stats/lifetime`

| Field | Type |
|-------|------|
| totalDistanceMeters | number |
| totalWalks | number |
| totalDurationMs | number |
| totalCaloriesKcal | number |
| totalSteps | number |
| averagePaceSecPerKm | number |
| currentStreakDays | number |
| longestStreakDays | number |
| lastWalkDate | string | `yyyy-MM-dd` local |
| updatedAt | timestamp |

### 1.5 `users/{userId}/stats/periods/{periodId}`

`periodId` formats: `w-2026-W30`, `m-2026-07`, `y-2026`

| Field | Type |
|-------|------|
| periodType | string | `week` \| `month` \| `year` |
| periodId | string | |
| distanceMeters | number |
| walks | number |
| durationMs | number |
| caloriesKcal | number |
| steps | number |
| dailyBreakdown | map | date → distanceMeters (week/month) |
| updatedAt | timestamp |

### 1.6 `users/{userId}/records/{recordId}`

| Field | Type | Examples |
|-------|------|----------|
| type | string | `longest_distance`, `fastest_pace_1k`, `most_calories`, `longest_duration`, `most_steps` |
| value | number | |
| unit | string | |
| walkId | string | |
| achievedAt | timestamp | |

### 1.7 `users/{userId}/achievements/{achievementId}`

| Field | Type |
|-------|------|
| badgeId | string | catalog id |
| unlockedAt | timestamp | |
| walkId | string? | |

### 1.8 `users/{userId}/goals/{goalId}`

| Field | Type |
|-------|------|
| type | string | `daily_distance` \| `weekly_distance` \| `weekly_walks` |
| targetValue | number | |
| unit | string | |
| active | bool | |
| createdAt | timestamp | |

### 1.9 `badgeCatalog/{badgeId}` (read-only public)

| Field | Type |
|-------|------|
| title | string |
| description | string |
| iconKey | string |
| criteria | map | |

### 1.10 Sync queue (client-only; not Firestore)

Drift table `sync_queue` — see local schema.

---

## 2. Firestore Indexes

Composite:
1. `walks`: `status ASC`, `startedAt DESC`
2. `walks`: `distanceMeters DESC` (records)
3. `walks`: `durationMs DESC`
4. `pointChunks`: `chunkIndex ASC`

---

## 3. Firebase Storage Paths

```
users/{userId}/avatar/{fileName}
users/{userId}/walks/{walkId}/points.json.gz
users/{userId}/walks/{walkId}/map_preview.png
users/{userId}/exports/{exportId}.json
```

---

## 4. Local Drift Schema (SQLite)

### 4.1 `local_users`
Mirrors essential profile for offline settings.

### 4.2 `walks`

| Column | Type |
|--------|------|
| id | text PK |
| remote_id | text? |
| user_id | text |
| title | text? |
| status | text | `in_progress` \| `paused` \| `completed` \| `discarded` |
| started_at | integer (ms) |
| ended_at | integer? |
| duration_ms | integer |
| paused_duration_ms | integer |
| distance_meters | real |
| avg_pace_sec_per_km | real |
| avg_speed_mps | real |
| max_speed_mps | real |
| calories_kcal | real |
| steps | integer |
| elevation_gain_m | real |
| elevation_loss_m | real |
| start_lat | real? |
| start_lng | real? |
| end_lat | real? |
| end_lng | real? |
| bounds_json | text? |
| polyline_encoded | text? |
| point_count | integer |
| sync_status | text | `pending` \| `syncing` \| `synced` \| `error` |
| sync_error | text? |
| sync_version | integer |
| created_at | integer |
| updated_at | integer |

### 4.3 `walk_points`

| Column | Type |
|--------|------|
| id | integer PK auto |
| walk_id | text FK |
| recorded_at | integer |
| lat | real |
| lng | real |
| altitude | real? |
| accuracy | real? |
| speed | real? |
| bearing | real? |
| is_filtered | integer | 0/1 rejected by GPS filter but kept for debug optional |

Index: `(walk_id, recorded_at)`

### 4.4 `walk_pauses`

| Column | Type |
|--------|------|
| id | integer PK |
| walk_id | text |
| paused_at | integer |
| resumed_at | integer? |

### 4.5 `sync_queue`

| Column | Type |
|--------|------|
| id | integer PK |
| entity_type | text | `walk` \| `profile` \| `stats` |
| entity_id | text |
| operation | text | `upsert` \| `delete` |
| payload_json | text? |
| attempts | integer |
| next_attempt_at | integer |
| created_at | integer |

### 4.6 `app_settings`

| Column | Type |
|--------|------|
| key | text PK |
| value | text |

### 4.7 `achievements_local` / `records_local`
Cached copies for offline dashboard.

---

## 5. Security Rules (Summary)

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isOwner(uid) {
      return request.auth != null && request.auth.uid == uid;
    }
    match /users/{userId} {
      allow read, write: if isOwner(userId);
      match /{document=**} {
        allow read, write: if isOwner(userId);
      }
    }
    match /badgeCatalog/{badgeId} {
      allow read: if request.auth != null;
      allow write: if false;
    }
  }
}
```

Storage:
```
match /users/{userId}/{allPaths=**} {
  allow read, write: if request.auth != null && request.auth.uid == userId
    && request.resource.size < 10 * 1024 * 1024;
}
```

---

## 6. Aggregation Rules

On walk complete (client transaction or Cloud Function):
1. Upsert walk summary.
2. Upload point chunks / gzip.
3. Increment `stats/lifetime`.
4. Upsert current week/month/year period docs.
5. Evaluate records & achievements.
6. Update streak using `lastWalkDate` + local calendar day.

**Write budget:** ~5–15 Firestore writes per completed walk (not per GPS point).

---

## 7. Calorie Formula

```
MET walking ≈ 3.5 (moderate) adjusted by pace:
  pace > 16 min/km → 2.8
  12–16 → 3.5
  10–12 → 4.3
  < 10 → 5.0
kcal = MET * weightKg * (durationHours)
```

---

## 8. Phase Gate

Phase 2 complete when schemas above are implemented as:
- `firestore.rules`, `firestore.indexes.json`
- Drift tables in `lib/core/database/`
- Documented mappers entity ↔ DTO ↔ Drift row
