# Checking a keyboard-sound preview: file measurements and their limits

Keeping the same speakers and system volume is a useful starting point when choosing a keyboard sound. It holds part of your listening setup steady. The recordings can still have different levels, lengths and playback gains, so that comparison does not establish equal perceived loudness.

I'm Levin, Klakk's developer. I prepared this methods note with AI assistance, using the website preview's current public mappings and an offline analysis on **October 12, 2026**. This is first-party numerical research, without a listening panel, microphone measurement or desktop-app performance test.

## What we inspected

The subject is the audio source used by [Klakk's browser preview](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=software-discovery&utm_content=preview-file-study-2026-10-12). The study covers four browser keys per pack: **A, Space, Enter and Backspace**. The preview maps those keys to identifiers 30, 57, 28 and 14 respectively.

The fourteen packs produce **56 mappings using 27 distinct audio files**. Several keys can point to the same file, so neither number describes the number of independently recorded performances or the entire pack catalog.

The current [public JavaScript](https://tryklakk.com/assets/js/demo.js) uses three arrangements:

| Arrangement | The measurement input |
| --- | --- |
| A single file reused for keys | The whole decoded file |
| Separate files assigned to keys | The file selected for that key |
| A long recording with key-specific offsets | Only the configured offset-and-duration window |

That last distinction matters. Measuring the whole timeline recording would also include other keys and gaps that do not belong to the selected keystroke. For example, the [Cherry MX Blue configuration](https://tryklakk.com/sounds/demo/cherry-blue-config.json) gives A a 164-millisecond window starting 28,961 milliseconds into its recording. The offset identifies a place in the file; it is not a keyboard-response delay.

The preview multiplies each clip by a base gain of 0.6 and a pack adjustment. The combined values include 0.6 for the Cherry MX packs, 0.33 for Apex Pro and Blackwidow Elite, and 2.1 for Gateron Red. The [Web Audio standard's GainNode definition](https://www.w3.org/TR/2021/REC-webaudio-20210617/#GainNode) describes multiplication of the input samples. A shared system-volume setting therefore leaves these recording and gain differences in place.

For the publication-scope check, we read the public JavaScript and six configuration bodies and confirmed that their SHA-256 values matched the source snapshot. The script SHA-256 is `dfc59c9b3218a4c6f1fc62153cb1192531bbb31e19d0ad6b1396ddd679c56dff`. The 27 audio URLs returned successful HEAD responses, but we did not fetch their remote bodies or confirm remote audio SHA-256. The numerical measurements below use the website-source file copies identified by their hashes; they are not an end-to-end verification of CDN media or live browser output.

## Define the numbers before comparing them

Our decoder kept each input's native sample rate and channel count. The analyzed files use 44.1 or 48 kHz, with one or two channels. We did not resample, normalize, remove DC, trim quiet tails or apply frequency weighting. The analysis environment reported python-soundfile 0.14.0 and libsndfile 1.2.2; record your decoder versions too, particularly for compressed audio.

For a selected clip with N sample frames and C channels:

```text
sample peak = max(abs(x[n, c]))
pooled RMS = sqrt(sum(x[n, c]^2) / (N * C))
level relative to 1.0 = 20 * log10(value / 1.0)
clip duration = N / sample_rate
```

“Relative to 1.0” uses a digital amplitude reference. We apply the same formula to peak and RMS, without adding a full-scale-sine RMS offset. The readings are not sound-pressure levels at a listener's ears. A zero value has no finite logarithmic level; the example code reports it as null rather than inventing a finite measurement.

The pooled RMS includes every retained sample in every channel, including zeros and quiet tails. A long quiet tail can reduce that average without changing the largest sample. This is one reason to preserve the measurement window in the record. Audacity's [Contrast documentation](https://manual.audacityteam.org/man/contrast.html) also explains that silent or low-level audio within the selected region is included.

For timeline clips, we round the start and end independently to the nearest native sample frame, with half frames rounded up. This is our offline-analysis convention. It does not claim to duplicate a browser's fractional-time rendering or resampling.

## The A-key snapshot

The following rows keep the current preview menu's order. They show one key per pack, not a listening rank or a claim about every keystroke. RMS is measured **before** the preview gain.

| Preview pack | A window / raw pooled RMS |
| --- | --- |
| Cherry MX Black | 160.0 ms / -33.9 dB |
| Cherry MX Blue | 164.0 ms / -30.7 dB |
| Cherry MX Brown | 198.0 ms / -39.7 dB |
| Cherry MX Red | 158.0 ms / -33.7 dB |
| Crystal Purple | 129.0 ms / -41.0 dB |
| Everglide Oreo | 109.0 ms / -40.9 dB |
| Gateron Black | 13.6 ms / -32.1 dB |
| Gateron Brown | 92.1 ms / -39.1 dB |
| Gateron Red | 68.8 ms / -43.7 dB |
| Banana Split Lubed | 185.9 ms / -36.4 dB |
| Banana Split Stock | 198.1 ms / -37.1 dB |
| NK Cream | 184.7 ms / -45.4 dB |
| Apex Pro | 169.8 ms / -27.7 dB |
| Blackwidow Elite | 304.8 ms / -29.0 dB |

The [complete 56-mapping numerical snapshot](data/keyboard-sound-preview-2026-10-12.csv) records each selected file SHA-256, key, window, sample rate, channels, gain and resulting values. It contains derived data and public file paths, with no audio payload. A blank configured duration means the mapping uses the whole file; the measured duration is recorded separately.

The selected A windows span approximately **13.6–304.8 milliseconds**. That measures the retained audio window, including its tail. It does not measure press-to-sound latency.

A separate, isolated calculation applies the observed preview gain to each decoded clip. Its A-key pooled RMS values span about **−44.2 to −30.5 dB relative to 1.0**. This is a gain model, not an output recording: it excludes overlapping keystrokes, browser decoding differences or resampling, system volume and the listening hardware.

Peak, RMS and standardized loudness are different measurements. [Audacity's Normalize documentation](https://manual.audacityteam.org/man/normalize.html) describes setting peak amplitude. [EBU R 128](https://tech.ebu.ch/docs/r/r128.pdf) describes programme loudness using a separate metering process. We did not measure LUFS or true peak here, and these rows do not establish which pack a person will perceive as loudest or prefer.

## Repeat the calculation on a local clip

Keep the file bytes and mapping from the same snapshot. Record the audio SHA-256, configuration SHA-256 when applicable, key, offset, duration, sample rate, channels and decoder versions. A file hash identifies those bytes; it does not establish ownership, sound quality or how an installed app plays them.

The following example reads a local file you provide and prints numbers. It does not download or play audio, modify the input, write a replacement recording or run Klakk. It requires NumPy and python-soundfile; the [library's official read documentation](https://python-soundfile.readthedocs.io/en/latest/#soundfile.read) explains its array and channel behavior.

Save the code as `measure_preview.py`. Arguments are the local filename, start milliseconds, duration milliseconds or `all`, and the isolated gain multiplier.

```python
import hashlib
import json
import math
import pathlib
import sys

import numpy as np
import soundfile as sf

path = pathlib.Path(sys.argv[1])
start_ms = float(sys.argv[2])
duration = sys.argv[3]
gain = float(sys.argv[4])
if not math.isfinite(start_ms) or start_ms < 0:
    raise ValueError("Start must be finite and nonnegative")
if not math.isfinite(gain) or gain < 0:
    raise ValueError("Gain must be finite and nonnegative")

x, rate = sf.read(path, dtype="float64", always_2d=True)
start = math.floor(start_ms * rate / 1000 + 0.5)
if duration == "all":
    end = len(x)
else:
    duration_ms = float(duration)
    if not math.isfinite(duration_ms) or duration_ms <= 0:
        raise ValueError("Duration must be finite and positive")
    end = math.floor((start_ms + duration_ms) * rate / 1000 + 0.5)
if not 0 <= start < end <= len(x):
    raise ValueError("Window is empty or outside the decoded file")
clip = x[start:end]
if not np.isfinite(clip).all():
    raise ValueError("Decoded clip contains nonfinite samples")

def level(value):
    return 20 * math.log10(value) if value > 0 else None

peak = float(np.max(np.abs(clip)))
rms = float(np.sqrt(np.mean(clip * clip)))
print(json.dumps({
    "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
    "sample_rate_hz": rate,
    "channels": clip.shape[1],
    "start_frame": start,
    "end_frame_exclusive": end,
    "window_ms": 1000 * len(clip) / rate,
    "raw_peak_db_re_1": level(peak),
    "raw_pooled_rms_db_re_1": level(rms),
    "isolated_gain": gain,
    "modeled_peak_db_re_1": level(peak * gain),
    "modeled_pooled_rms_db_re_1": level(rms * gain),
    "soundfile_version": sf.__version__,
    "libsndfile_version": sf.__libsndfile_version__,
}, indent=2, allow_nan=False))
```

For the snapshot's A-key Cherry MX Blue mapping:

```sh
python measure_preview.py cherry-blue.ogg 28961 164 0.6
```

It gives approximately 164.0 ms and raw pooled RMS −30.7 dB relative to 1.0 for the input identified in this snapshot. Its input SHA-256 is `68d46de5a091e4d6daf468327c87e3e75494e645dacc8d55418d5151aaf84349`. A different hash is a different input, even when the filename is identical. For a whole-file mapping such as Gateron Red, use start `0`, duration `all` and its observed combined gain `2.1`. Recheck the current public mapping before applying either example to a future website revision.

These examples reproduce a file calculation. The [Web Audio decoding specification](https://www.w3.org/TR/2021/REC-webaudio-20210617/#dom-baseaudiocontext-decodeaudiodata) permits resampling to the audio-context sample rate, so an original-rate calculation does not by itself verify the browser's rendered samples. We have not distributed recordings or application source with this note, or established that the website sources match every installed-app key and version.

## What this can help you decide

Use the data to understand the comparison conditions. Use the preview and your own trial to decide whether you enjoy a sound. A louder recording, a higher sample peak or a longer clip is not a demonstrated quality advantage.

Klakk's website editions include the fourteen packs in a three-day trial from first launch. Continued use is US$4.49 once per platform, plus applicable tax; website Mac, Windows and Mac App Store licenses are separate. Website Mac needs macOS 14+ on Apple silicon or Intel; Windows needs Windows 10/11 on native x64 or ARM64. The current Windows installers are unsigned. The repository README provides current release and file-verification links.

[Choose the Mac or Windows website edition](https://tryklakk.com/en/download/?utm_source=github&utm_medium=referral&utm_campaign=software-discovery&utm_content=preview-file-study-2026-10-12) after listening. Local playback still includes usage analytics and licensing communication; Mac also has settings telemetry. Typed text and raw key events are not uploaded. Read the applicable [Mac privacy policy](https://tryklakk.com/en/privacy/) or [Windows privacy policy](https://tryklakk.com/en/windows/privacy/) before choosing.
