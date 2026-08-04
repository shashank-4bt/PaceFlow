# Google Play Data Safety Form — PaceFlow

Answers for **Play Console → App content → Data safety**. Customize before submission. Marked as template — verify against actual SDK behavior and attorney guidance.

**App:** PaceFlow (`com.paceflow.paceflow`)  
**Category:** Health & Fitness  
**Account required:** Yes (for cloud sync)

---

## Summary for users (Play-generated preview)

> PaceFlow collects location, personal info, and fitness data to provide walk tracking and sync. Data is encrypted in transit. You can request deletion. Data is not sold.

---

## Data collection overview

| Collected? | Shared? | Required? | Purpose |
|------------|---------|-----------|---------|
| Yes | No (processors only) | Mixed | App functionality |

**Does your app collect or share user data?** → **Yes, collected**

**Is all collected data encrypted in transit?** → **Yes**

**Do you provide a way for users to request deletion?** → **Yes** (in-app delete account + email)

---

## Data types

### Location

| Field | Answer |
|-------|--------|
| Approximate location | **No** (app uses precise GPS for routes) |
| Precise location | **Yes — Collected** |
| Ephemeral? | **No** — stored in account |
| Required or optional | **Optional** (core feature requires permission) |
| Purposes | App functionality, Analytics (aggregated) |
| Shared? | **No** (Firebase is processor, not "sharing" for ads) |

### Personal info

| Data type | Collected | Purpose |
|-----------|-----------|---------|
| Name | Yes | Account, App functionality |
| Email address | Yes | Account, App functionality |
| User IDs | Yes (Firebase UID) | Account |
| Photos | Optional (profile avatar) | App functionality |

### Health and fitness

| Data type | Collected | Purpose |
|-----------|-----------|---------|
| Fitness info | Yes (distance, pace, steps, calories, routes) | App functionality |

### App activity

| Data type | Collected | Purpose |
|-----------|-----------|---------|
| App interactions | Yes (Firebase Analytics events) | Analytics |
| Other user-generated content | Yes (walk titles, goals) | App functionality |

### App info and performance

| Data type | Collected | Purpose |
|-----------|-----------|---------|
| Crash logs | Yes (Crashlytics) | Analytics, App functionality |
| Diagnostics | Yes | Analytics |

### Device or other IDs

| Data type | Collected | Purpose |
|-----------|-----------|---------|
| Device or other IDs | Yes (FCM token, Analytics instance ID) | App functionality, Analytics |

---

## Data NOT collected (declare explicitly)

- Financial info
- Messages / SMS
- Web browsing history
- Contacts
- Calendar
- Files and docs (beyond app-generated exports user saves manually)

---

## Data handling

| Question | Answer |
|----------|--------|
| Data sold | **No** |
| Data used for advertising | **No** |
| Data used for creditworthiness | **No** |
| Prominent disclosure for location | **Yes** — in-app permission dialogs + Privacy Policy |
| Independent security review | **No** (unless you obtain one) |

---

## Security practices

- Data encrypted in transit (TLS)
- Users can request deletion (Settings → Delete Account)
- Data processed per Firebase security rules (owner-only access)

---

## Account deletion link

Provide URL in Play Console:

```
https://yourdomain.com/delete-account
```

Or describe in-app path: **Profile → Settings → Delete Account**

---

## Privacy policy URL

```
https://yourdomain.com/privacy
```

Must match live policy before production release.

---

## SDK disclosure notes

Document internally that these SDKs may collect data per their policies:

- Firebase Auth, Firestore, Storage, Analytics, Crashlytics, FCM
- Google Maps SDK
- Google Sign-In

Review [Google Play SDK Index](https://sdk.google.com/) entries when submitting.

---

## Submission checklist

- [ ] Answers match `assets/legal/privacy_policy.md`
- [ ] Location declared as precise, not ephemeral
- [ ] Health/fitness category selected
- [ ] Deletion mechanism tested and documented
- [ ] Privacy policy URL live and linked
- [ ] No "Not collected" selected for GPS app core data

---

*Template — verify all answers before Play Console submission.*
