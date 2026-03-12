# Font Subsetting Guide

## What is font subsetting?

Font files contain glyphs (visual representations) for every character the font supports. A full Cormorant Garamond file includes Latin, Cyrillic, Vietnamese, Greek, and extended diacritics — most of which an English site will never render.

Font subsetting strips unused glyphs, keeping only the character ranges you need. For this project, we keep the **Latin** subset.

## Results

| Font | Before | After | Reduction |
|------|--------|-------|-----------|
| CormorantGaramond-Light | 108 KB | 18 KB | 83% |
| CormorantGaramond-LightItalic | 76 KB | 19 KB | 75% |
| CormorantGaramond-Regular | 115 KB | 19 KB | 83% |
| CormorantGaramond-SemiBold | 117 KB | 20 KB | 83% |
| CormorantGaramond-Bold | 111 KB | 19 KB | 83% |
| **Total (all 10 variants)** | **~950 KB** | **~195 KB** | **~80%** |

## How to subset

### Prerequisites

```sh
flox install python313Packages.fonttools python313Packages.brotli
```

### Command

```sh
flox activate -- pyftsubset <input.ttf> \
  --output-file=<output.woff2> \
  --flavor=woff2 \
  --unicodes="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD"
```

### Unicode ranges explained

| Range | Description |
|-------|-------------|
| `U+0000-00FF` | Basic Latin + Latin-1 Supplement (ASCII, accented chars like é ñ ü) |
| `U+0131` | Latin small letter dotless i (Turkish) |
| `U+0152-0153` | OE ligatures (Œ œ) |
| `U+02BB-02BC` | Modifier letters (ʻ ʼ) |
| `U+02C6,U+02DA,U+02DC` | Circumflex, ring above, tilde |
| `U+0304,U+0308,U+0329` | Combining diacritical marks |
| `U+2000-206F` | General punctuation (em dash, curly quotes, ellipsis, etc.) |
| `U+2074` | Superscript 4 |
| `U+20AC` | Euro sign (€) |
| `U+2122` | Trademark (™) |
| `U+2191,U+2193` | Arrows (↑ ↓) |
| `U+2212,U+2215` | Minus sign, division slash |
| `U+FEFF,U+FFFD` | BOM and replacement character |

This is the standard "Latin" subset used by Google Fonts.

### Batch subset all fonts

```sh
LATIN="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+0304,U+0308,U+0329,U+2000-206F,U+2074,U+20AC,U+2122,U+2191,U+2193,U+2212,U+2215,U+FEFF,U+FFFD"

for name in Light LightItalic Regular Italic Medium MediumItalic SemiBold SemiBoldItalic Bold BoldItalic; do
  flox activate -- pyftsubset \
    "src/assets/fonts/Cormorant_Garamond/static/CormorantGaramond-${name}.ttf" \
    --output-file="src/assets/fonts/Cormorant_Garamond/static/CormorantGaramond-${name}.woff2" \
    --flavor=woff2 \
    --unicodes="$LATIN"
done
```

### Important notes

- **Always subset from the original TTF source**, not from a previously converted WOFF2. WOFF2 files produced by `woff2_compress` may be missing required font tables (like `post`) that `pyftsubset` needs.
- The `--flavor=woff2` flag handles the WOFF2 compression — no need to run `woff2_compress` separately.
- The `brotli` Python package is required for WOFF2 output.

## font-display strategy

We use a split strategy based on whether the font is needed above the fold:

| Font | font-display | Reason |
|------|-------------|--------|
| Light (300 normal) | `swap` | Hero subtitle, newsletter title |
| Light Italic (300 italic) | `swap` | Hero title |
| Regular (400 normal) | `swap` | Nav, CTAs, default text |
| All others | `optional` | Below-the-fold only; renders with system font if not cached |

- **`swap`**: Shows fallback font immediately, swaps to web font when loaded. Ensures above-the-fold text always uses Cormorant Garamond.
- **`optional`**: Gives the font ~100ms to load. If it misses the window, the system font is used for that page load (font is cached for next visit). No layout shift, no render delay.
