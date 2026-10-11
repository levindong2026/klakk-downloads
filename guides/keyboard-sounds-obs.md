# Keyboard sounds missing from OBS: playback, capture, and recording tracks

[日本語](keyboard-sounds-obs.ja.md)

Check whether the keyboard app produces sound first, whether OBS receives that sound second, and whether the saved recording contains it third. Each check points to a different part of the setup.

Updated **2026-10-10**. Maintained by **Levin, developer of Klakk**, with AI assistance. The OBS instructions below come from the linked official documentation; this is a diagnosis checklist, not a report of testing every keyboard app with OBS.

## 1. Find where the sound stops

Use the same headphones or speakers for both tests. Type a short sample in a local editor such as Notepad or TextEdit, then in the OBS text field where you noticed the problem. Listen to the app's playback before changing capture settings.

| What you observe | What to check next |
| --- | --- |
| The keyboard app is silent in both places. | Check app playback, volume, output device, permissions and trial or activation status. Klakk users can follow the [Windows and Mac first-sound checks](klakk-no-sound.md). |
| Effects play in the editor but stop while typing inside OBS. | Record the two app versions and the exact focused window. Investigate input or playback first; capture settings alone do not establish why the app stops producing sound. |
| You hear effects locally, but the corresponding OBS capture-source meter does not respond. | Check which application or output device the source captures, and the source's mute, volume and routing settings. Continue with the platform-specific section below. |
| The corresponding source meter responds, but the saved video seems silent. | Check the source's mute state, recording-track assignment, enabled output tracks and the track selected in your player. Continue with section 3. |

An [OBS forum report from June 2024](https://obsproject.com/forum/threads/mechvibes-sounds-not-working-in-obs.175886/) describes Mechvibes playing in other apps but failing while typing inside OBS. The visible thread does not establish a cause or fix. It illustrates why a playback problem and a recording problem need separate tests; it does not demonstrate that Klakk resolves that case.

## 2. Check the capture source for your platform

### Windows

According to the [OBS Application Audio Capture guide](https://obsproject.com/kb/application-audio-capture-guide), OBS 28 or later supports per-application audio capture on Windows 10 version 2004 or later and Windows 11. OBS 30.1 or later also offers audio capture in Window Capture and Game Capture sources.

Select the application producing the effects. OBS advises disabling global **Desktop Audio** when using per-application sources to avoid duplicate audio or echo. Its documentation also warns that some applications' audio output is incompatible with per-application capture. Check your actual source meter and saved clip; this guide does not establish Klakk-specific capture compatibility.

### Mac

The [OBS macOS audio guide](https://obsproject.com/kb/macos-desktop-audio-capture-guide) describes **macOS Audio Capture** in OBS 30 or later on macOS 13 or later. It can capture all desktop audio or a selected application. **macOS Screen Capture** can also capture audio, so inspect that source when reviewing what enters a recording.

Keep the keyboard app's selected playback output and the OBS capture target in view. Hearing effects in headphones establishes local playback, not their presence or absence in the recorded file.

## 3. Check the saved file's audio tracks

In **Audio Mixer → Advanced Audio Properties**, inspect which recording tracks receive the sound source. In **Settings → Output**, check that those tracks are enabled for recording. Then select the intended audio track in your player or editor.

OBS explains that standard players play one audio track at a time. A source on a separate track can therefore appear missing during ordinary playback. Choose deliberately whether your shareable mix includes the effects and whether you also need separate editing tracks. See the [official multiple-audio-track guide](https://obsproject.com/kb/multiple-audio-track-recording-guide).

## 4. Verify the result with a short recording

Record a brief clip using the intended scene, typing location and output device. Save it, open it, and check the intended audio track. Change one setting at a time so you can tell which change affected the result.

If you want to keep effects out of a recording, check both digital capture and microphone pickup. Headphones can reduce speaker-to-microphone leakage, while desktop or application capture can still include their audio directly. The [keyboard-recording setup guide](https://tryklakk.com/en/blog/quiet-keyboard-for-content-creators-recording/?utm_source=github&utm_medium=referral&utm_campaign=software_discovery&utm_content=obs_capture_checklist_en) covers those paths.

For an unresolved problem, report your OS, OBS version, keyboard-app version, the focused typing window, selected playback output, capture-source type and the first failed check above. These observations are more useful than reporting only that the recording is silent.

## Klakk version scope

The current website editions are **Mac 1.4.1/build 23** and **Windows 1.4.1**. Mac requires macOS 14 or later on Apple silicon or Intel; Windows supports Windows 10/11 on native x64 or ARM64. The Windows installer is unsigned. These app requirements are separate from the OBS capture-feature requirements above. [Official downloads](../README.md#download-klakk-141) and the [first-sound guide](klakk-no-sound.md) explain installation, permissions and licensing.
