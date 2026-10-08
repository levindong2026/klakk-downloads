# Klakk has no sound: checks for Windows and Mac

Maintained by the Klakk developer. Updated October 8, 2026, for Klakk 1.4.1.

[日本語](klakk-no-sound.ja.md) · [Downloads and checksums](../README.md#download-klakk-141)

If Klakk is installed but typing is silent, check the app's playback, volume, output device, Background Mode and trial status. On Mac, also check Input Monitoring. The steps below help you check your setup before reinstalling.

## Check where you expect the sound to play

The [browser sound preview](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_en) works inside its preview page. To hear keyboard sounds while typing in other applications, install and open the desktop app.

Klakk plays additional audio through speakers or headphones. Your keyboard's physical sound and feel stay the same. If you want the added audio to stay with you, use headphones.

## Windows: check playback and the selected output

Klakk supports Windows 10 and 11 on ARM64 and Intel/AMD x64. One installer selects the native build. 32-bit Windows is unsupported.

1. Open Klakk. In **General**, turn on **Enable Klakk**.
2. In **Audio**, select a sound pack and set Klakk's volume above zero.
3. In **Audio → Output Device**, select your connected speakers or headphones. Choose **System Default** to use the Windows default output.
4. Open the Windows volume mixer and check that Klakk is not muted. On Windows 11, use **Settings → System → Sound → Volume mixer**. On Windows 10, right-click the taskbar volume icon and open **Volume mixer**.
5. Type a short sentence in a local text editor such as Notepad. If you have changed headphones, check Klakk's output selection again.

Choosing a specific output in Klakk can leave it routed to that device when you change the Windows default. Check both settings. Microsoft's [app-audio troubleshooting guide](https://support.microsoft.com/en-us/windows/hardware/audio/fix-app-audio-not-working-while-system-sounds-work-in-windows) explains the system controls.

## Mac: check Input Monitoring and the app's output

The Mac edition requires macOS 14 or later and supports Apple silicon and Intel Macs.

1. Open the installed copy of Klakk in Applications and enable playback in the app.
2. In **System Settings → Privacy & Security → Input Monitoring**, enable Klakk. Quit and reopen Klakk if macOS requests it after a permission change.
3. In Klakk's audio settings, choose a sound pack and set the app volume above zero.
4. Check Klakk's output device. Select your connected speakers or headphones, or choose **System Default** and check the Mac's selected output and volume.
5. Type a short sentence in a local writing app. Recheck the output selection after connecting or disconnecting headphones.

Input Monitoring lets Klakk react to key events while you type in another app. Apple's [Input Monitoring guide](https://support.apple.com/guide/mac-help/control-access-to-input-monitoring-on-mac-mchl4cedafb6/mac) explains how to control access. Read the [Mac privacy policy](https://tryklakk.com/en/privacy/) before granting permission.

## If the sound becomes very quiet, check Background Mode

In **Audio**, temporarily turn off **Background Mode** and type again. On the Japanese interface, this setting is 「バックグラウンドモード」.

When enabled, this feature reduces keyboard playback volume while designated meeting or media applications are running, such as Zoom or Spotify. It checks whether those apps are running, so pausing music or ending a call while leaving the app open can still leave Klakk quieter. Turn Background Mode back on if you prefer that behavior.

If the sound remains quiet, continue with the output and license checks. If other applications are also silent, check your OS output, volume and device connection.

## Check the trial and the purchase channel

All 14 sound packs are included in the trial, which lasts **3 days from first launch**. Continued playback after the trial needs an active license for the edition you installed. Reinstalling is not a way to restart the trial.

| Your edition | Purchase and activation |
| --- | --- |
| Windows | US$4.49 once through Creem, plus applicable tax. If already purchased, open **Purchase Klakk → Check activation**. **Restore Purchase** accepts the Windows license key from your purchase email. |
| Mac downloaded from the website or the Klakk Homebrew tap | US$4.49 once through Creem, plus applicable tax. Use the Mac website edition's purchase or restore flow. |
| Mac App Store | Use Apple's purchase or restore flow. The current regional price appears in Apple's purchase screen. |

Windows, the Mac website edition and the Mac App Store edition have separate licenses. A purchase for one edition does not activate the others. See the [product terms](https://tryklakk.com/en/terms/) for purchase details.

## Check an installer before running it

Use the [official download links and SHA-256 checksums](../README.md#verify-the-download) for the same version and filename. Run the listed command in the folder where you saved the file, then compare its entire hash with the published value. Hexadecimal letter case does not change the value.

If the hash differs, stop and obtain the file again from the official release. A matching checksum confirms the file matches the published copy; it does not replace publisher signing. The current Windows installer is unsigned. The Mac DMG contains a Developer ID-signed, Apple-notarized app.

## Send a useful support report

If you still hear nothing, use [Klakk support](https://tryklakk.com/en/support/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_en). Include your OS version, Klakk version, Windows architecture or Mac chip, selected output, trial or purchased status, and the checks you tried.

Keep license keys, purchase emails and private text out of public issues. Klakk does not upload your typed text or keystroke content; usage analytics and license communication are separate. Details are in the [Windows privacy policy](https://tryklakk.com/en/windows/privacy/) and [Mac privacy policy](https://tryklakk.com/en/privacy/).

If you have not installed Klakk yet, [preview the sounds](https://tryklakk.com/en/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_en), then [choose your platform and start the trial](https://tryklakk.com/en/download/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_en).
