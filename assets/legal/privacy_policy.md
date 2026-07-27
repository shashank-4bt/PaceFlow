# PaceFlow Privacy Policy

**Effective date:** [INSERT DATE]  
**Last updated:** [INSERT DATE]

> **LEGAL NOTICE — TEMPLATE ONLY**  
> This document is a draft privacy policy template for a GPS fitness tracking mobile application. It is **not legal advice**. Have a qualified attorney review and customize this policy for your jurisdiction, business entity, data practices, and applicable laws (including GDPR, UK GDPR, CCPA/CPRA, and other regional requirements) before publication.

**Data Controller / Operator:** [YOUR LEGAL ENTITY NAME]  
**Contact email:** [privacy@yourdomain.com]  
**Registered address:** [YOUR BUSINESS ADDRESS]  
**App name:** PaceFlow  
**Package name:** com.paceflow.paceflow

---

## 1. Introduction

PaceFlow ("we," "us," or "our") provides a mobile application that helps you track walks, view routes on a map, and monitor fitness statistics such as distance, pace, calories, and steps.

This Privacy Policy explains how we collect, use, disclose, store, and protect personal information when you use the PaceFlow app and related services (collectively, the "Service").

By creating an account or using the Service, you acknowledge that you have read this Privacy Policy. If you do not agree, do not use the Service.

---

## 2. Information We Collect

### 2.1 Account information

When you register, we may collect:

- Email address
- Display name
- Profile photo (if you upload one or sign in with Google)
- Authentication identifiers from Firebase Authentication
- Optional profile fields (bio, weight, height, unit preferences)

### 2.2 Location and activity data

PaceFlow is a GPS fitness app. When you start a walk and grant location permissions, we collect:

- Precise GPS coordinates (latitude, longitude)
- Timestamps for each recorded point
- Optional altitude, speed, bearing, and horizontal accuracy
- Derived route metrics: distance, pace, duration, elevation gain/loss
- Step counts from device sensors (where supported and permitted)
- Encoded route polylines and walk summaries

**Background location:** If you enable background tracking, location may be collected while the app is not in the foreground so your walk continues to be recorded. You can disable this in device settings or by ending a walk.

### 2.3 Device and usage information

We may automatically collect:

- Device model, operating system version, and app version
- IP address (typically processed by our hosting providers)
- Crash logs and diagnostic data via Firebase Crashlytics
- Analytics events (e.g., sign-up method, feature usage) via Firebase Analytics
- Push notification tokens (FCM) if you enable notifications
- Network connectivity status for offline sync

### 2.4 Content you provide

- Walk titles, goals, and settings
- Shared export images you generate within the app
- Support correspondence if you contact us

### 2.5 Information from third parties

If you sign in with Google, we receive basic profile information permitted by your Google account settings (such as name, email, and profile picture) according to Google's policies.

---

## 3. How We Use Information

We use personal information to:

1. Provide core app functionality (account creation, walk tracking, maps, statistics)
2. Sync your data across devices via Firebase Cloud Firestore and Storage
3. Calculate fitness metrics (distance, pace, calories, streaks, badges)
4. Send optional notifications (daily reminders, goal milestones) if enabled
5. Maintain security, prevent fraud, and enforce our Terms
6. Improve reliability through crash reporting and aggregated analytics
7. Respond to support requests and legal obligations

We do **not** sell your personal information.

---

## 4. Legal Bases for Processing (EEA/UK users)

Where GDPR or UK GDPR applies, we process personal data on these bases:

| Purpose | Legal basis |
|---------|-------------|
| Account and walk tracking | Performance of contract |
| Optional notifications | Consent (withdrawable in settings) |
| Background location | Consent (device permission) |
| Analytics and crash reporting | Legitimate interests (app improvement) |
| Legal compliance | Legal obligation |

You may withdraw consent for optional processing without affecting core tracking if you disable the relevant feature or permission.

---

## 5. Location Data — Important Notice

Location data is **special category-adjacent sensitive data** in many contexts because it can reveal where you live, work, or exercise.

- We store route data under your user account in Firebase, accessible only to you under our security rules.
- You may disable precise location storage in privacy settings (summary-only upload) if offered in the app.
- Deleting your account triggers deletion of associated cloud data subject to backup retention periods described below.

---

## 6. Data Sharing and Processors

We share information only as necessary with service providers ("processors") that help operate the Service:

| Provider | Purpose |
|----------|---------|
| Google Firebase (Auth, Firestore, Storage, Analytics, Crashlytics, FCM) | Backend infrastructure |
| Google Maps Platform | Map display |
| Google Sign-In | Authentication |

These providers process data under contractual terms requiring appropriate safeguards. We may also disclose information if required by law, to protect rights and safety, or in connection with a merger or acquisition with notice where required.

We do not share your precise walk routes with other users unless you explicitly enable a future social/sharing feature.

---

## 7. International Transfers

Firebase and Google services may process data in the United States and other countries. Where required, we rely on Standard Contractual Clauses or equivalent mechanisms. Contact us for transfer details.

---

## 8. Data Retention

- **Account data:** retained while your account is active.
- **Walk history:** retained until you delete individual walks or your account.
- **Crash/analytics logs:** typically retained per Firebase default periods (often 90 days to 14 months depending on product).
- **Backups:** residual copies may persist in encrypted backups for up to [30–90] days after deletion.

We may retain anonymized or aggregated data that cannot identify you.

---

## 9. Security

We implement technical and organizational measures including:

- Firebase Authentication and owner-scoped Firestore/Storage security rules
- Encrypted local storage for sensitive tokens (Android Keystore / secure storage)
- TLS in transit for network communication
- App Check (when enabled) to reduce unauthorized API access

No method of transmission or storage is 100% secure. Report suspected breaches to [security@yourdomain.com].

---

## 10. Your Rights and Choices

Depending on your location, you may have rights to:

- Access, correct, or delete personal data
- Export your data (data portability)
- Object to or restrict certain processing
- Withdraw consent
- Lodge a complaint with a supervisory authority

**In-app:** Profile → Settings → Delete Account (or contact us).  
**Email:** [privacy@yourdomain.com]

California residents may have additional rights under CCPA/CPRA, including knowing categories collected and requesting deletion. We do not sell personal information.

---

## 11. Children's Privacy

The Service is not directed to children under 13 (or 16 in the EEA/UK without parental consent). We do not knowingly collect data from children. Contact us to request deletion if you believe a child provided personal information.

---

## 12. Third-Party Links

The Service may link to third-party websites or services. We are not responsible for their privacy practices.

---

## 13. Changes to This Policy

We may update this Privacy Policy. We will post the revised version in the app and update the "Last updated" date. Material changes may require additional notice or consent where required by law.

---

## 14. Contact Us

**[YOUR LEGAL ENTITY NAME]**  
Email: [privacy@yourdomain.com]  
Address: [YOUR BUSINESS ADDRESS]

For EU/UK representative (if applicable): [EU/UK REPRESENTATIVE DETAILS]

---

*Template version 1.0 — PaceFlow GPS fitness app. Requires attorney review before publication.*
