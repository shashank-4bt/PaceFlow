# Feature Graphic Design Brief — PaceFlow

**Canvas:** 1024 × 500 px  
**Format:** PNG or JPEG (24-bit, no transparency required)  
**Usage:** Google Play Store top banner (all visitors)

---

## Brand foundation

| Token | Hex | Usage |
|-------|-----|-------|
| Primary black | `#0B0B0B` | Background base |
| Emerald accent | `#22C55E` | CTA highlights, route line, logo glow |
| Electric blue | `#3B82F6` | Secondary gradient stop |
| White | `#FFFFFF` | Headline text |
| Muted gray | `#B0B0B0` | Subhead, tagline |

**Typography:** Plus Jakarta Sans (Bold 700 for headline, Medium 500 for subhead)

**Tagline:** *Every Step Has a Story.*

---

## Layout concept

```
┌────────────────────────────────────────────────────────────── 1024px ──┐
│  [Dark gradient bg #0B0B0B → #141414]                                │
│                                                                        │
│   PaceFlow          ┌─────────────────────┐                           │
│   (wordmark)        │  Phone mockup       │   LIVE GPS WALKS          │
│   emerald accent    │  map + route line   │   Track distance, pace,   │
│                     │  (emerald polyline) │   and calories            │
│                     └─────────────────────┘                           │
│   Every Step Has a Story.                                              │
│                                                                        │
└────────────────────────────────────────────────────────── 500px ─────┘
```

### Left third (340 px)

- **PaceFlow** logotype: white, bold, ~48–56 pt equivalent
- Small emerald dot or underline beneath "Flow"
- Tagline below in `#B0B0B0`, ~18–22 pt

### Center (360 px)

- Phone frame (optional): dark bezel, rounded corners
- Inside: stylized map (dark tiles) with **emerald route polyline** and start/end pins
- Floating mini stat chips: `2.41 km` · `32:15` · `5:28/km`

### Right third (324 px)

- Headline: **LIVE GPS WALKS** (white, bold, 2 lines max)
- Subcopy: "Track distance, pace, and calories" (gray)
- Optional emerald pill: "Offline-first"

---

## Visual rules

1. **High contrast** — readable at thumbnail size in Play Store search.
2. **No clutter** — max 3 text blocks plus logo.
3. **No fine print** — legal text belongs in listing, not graphic.
4. **No Google Play badge** in the image (Google adds their own UI).
5. **No misleading claims** — show features available in v1.0.
6. Avoid pure black `#000000`; use `#0B0B0B` for brand match with app splash.

---

## Gradient specification

Linear gradient, 135° (top-left → bottom-right):

- Stop 0%: `#0B0B0B`
- Stop 50%: `#141414`
- Stop 100%: `#0B0B0B` with subtle emerald glow (`#22C55E` at 8% opacity) bottom-right

Optional accent orb: 200 px circle, `#22C55E` at 20% opacity, blurred 80 px, top-right behind phone.

---

## Route line (map mock)

- Stroke: 4 px, `#22C55E`, rounded caps
- Secondary glow: duplicate path, 8 px, `#22C55E` at 30% opacity
- Map background: `#1A1A1A` with faint grid lines `#2A2A2A`

---

## Export checklist

- [ ] Exact dimensions 1024 × 500 px
- [ ] sRGB color profile
- [ ] File size under 1 MB (JPEG quality 85–90 acceptable)
- [ ] Text legible at 50% zoom
- [ ] Saved as `store_listing/feature_graphic_1024x500.png`

---

## Figma / design tool setup

1. Create frame: **1024 × 500**, name `Play Feature Graphic`.
2. Add layout grids: 3 columns (340 / 344 / 340) with 16 px margins.
3. Import Plus Jakarta Sans from Google Fonts plugin.
4. Export @1x PNG.

---

## Alternative minimal variant

If time-constrained: full-bleed `#0B0B0B`, centered **PaceFlow** wordmark in white, emerald route SVG snaking behind text, tagline underneath. Still meets brand requirements without phone mockup.
