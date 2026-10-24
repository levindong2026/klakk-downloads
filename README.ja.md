# Klakk — Windows・Mac向けキーボード音アプリ

## 現在の公式サイト版リビジョン — 2026-10-11.1

Mac・Windowsとも公開バージョンは**1.4.1**、Macのbuildは**23**のままです。最新の直ダウンロード更新は[この公式リリース](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1-r20261011.1)から取得できます。新規インストールのログイン時自動起動、閉じられる試用案内、購入画面の「購入を復元」文字リンクを更新しました。以前オフにした自動起動の選択は保持されます。

[Windows自動選択インストーラー](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup-r20261011.1.exe) · [Mac DMG](https://downloads.tryklakk.com/Klakk-1.4.1-23-r20261011.1.dmg)。小さいx64/ARM64版とSHA-256は上記リリースにあります。Windows版は未署名です。Macアプリ本体は公証・staple済みですが、署名付きDMGの外側は別途公証していません。

試用は初回起動から3日間、継続利用は各プラットフォームUS$4.49買い切り＋該当税です。公式サイトMac版、Windows版、App Store版は別ライセンスです。以下の旧ファイル、チェックサム、パッケージ管理ツールの固定ファイルは以前の1.4.1のまま保持しています。

Klakk開発者が管理する公式ダウンロードページです。普段のキーボードで文字を入力すると、Klakkが打鍵音を再生します。キーの感触や、キーボード自体が出す物理的な音は変わりません。

[English](README.md) · [公式サイト](https://tryklakk.com/ja/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads) · [ブラウザで音を試す](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

動画で聴きたい方は、[44秒の英語版サウンドプレビュー](https://www.youtube.com/watch?v=rkSXD7r3Dy4)をご覧ください。Gateron Red、Cherry MX Blue、Banana Split Stock の編集された音サンプルを紹介します。14種類すべての音はブラウザのデモで試せます。

### 7音色を80秒で聴く（英語画面）

https://github.com/user-attachments/assets/e095b634-fb1b-476f-81ec-f9c5aa0a7c3c

同梱音源7種類を、同じ12打の順番・間隔で各8秒ずつ再生した編集プレビューです。画面は英語で、ナレーションや日本語字幕はありません。アプリの操作録画や、音の大きさをそろえた比較、遅延測定を示す映像ではありません。

[14音色をブラウザーで試聴](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)して、好きな音を選べます。[Mac公式サイト版](https://tryklakk.com/ja/download/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)と[Windows版](https://tryklakk.com/ja/windows/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)は、初回起動から3日間、14音色を試せます。継続利用は各プラットフォームUS$4.49の買い切り＋適用税です。公式サイトMac版・Windows版・Mac App Store版は別ライセンスです。

Klakk開発者Levinが管理する紹介です。説明文の作成にAIを補助として使用しました。[この動画の音源の出典とライセンス](docs/klakk-seven-included-sounds-en-NOTICE.txt)

インストール後に音が出ない場合は、[Windows・Mac の確認手順](guides/klakk-no-sound.ja.md)で、有効化、出力先、権限、試用・ライセンス状態を確認できます。

OBSで録画する場合は、[キーボード音の再生・音声取り込み・録音トラックを分けて確認](guides/keyboard-sounds-obs.ja.md)してください。手元で聴こえる音と、保存動画に入る音を別々に調べる手順です。

## Klakk 1.4.1をダウンロード

| OS | 動作環境 | インストーラー |
| --- | --- | --- |
| Windows | Windows 10 / 11、ARM64またはIntel/AMD x64。32ビット版Windowsには非対応 | [Windows版をダウンロード](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup.exe) |
| Mac | macOS 14以降、AppleシリコンまたはIntel Mac | [Mac版DMGをダウンロード](https://downloads.tryklakk.com/Klakk-1.4.1-23.dmg) |

[SHA-256チェックサム](SHA256SUMS.txt) · [公式サイトのダウンロード案内](https://tryklakk.com/ja/download/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

通常の配布先に接続できない場合は、[公式GitHubリリース](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1)から入手できます：[Windowsインストーラー](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-Setup.exe) · [Mac DMG](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-23.dmg)。両方の配布先でファイルとチェックサムは同一です。

<details>
<summary>CPUの種類が分かる場合の小さいWindows配布ファイル</summary>

**Windows 10/11の64ビット版**で、「設定 → システム → バージョン情報」の「システムの種類」を確認してください。不明な場合は、上の通常のWindowsインストーラーがPCに合う版を自動で選びます。

| CPU | 1.4.1の配布ファイル | ダウンロードサイズ |
| --- | --- | ---: |
| Intel / AMD x64 | [x64版をダウンロード](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-x64-Setup.exe) | 105.4 MB |
| ARM64 | [ARM64版をダウンロード](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-arm64-Setup.exe) | 99.1 MB |

CPU別に同じ**Klakk 1.4.1のアプリ、実行環境、14音源**を含みます。通常版の202.2 MBより配布ファイルが小さく、インストールされるアプリのファイルは同じです。Windows版は引き続き**未署名**です。

この2ファイルには[専用チェックサム](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/SHA256SUMS-windows-native.txt)を使います。[ネイティブrunnerでの検証](https://github.com/levindong2026/klakk-downloads/actions/runs/38068672800)では382ファイルの一致、導入、再導入、異なるCPUでの拒否、削除を確認しました。アプリは起動しておらず、配布の整合性を確認するQAです。利用者のインストール数や性能の証明ではありません。

[Windows版の動作環境と設定](https://tryklakk.com/ja/windows/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads&utm_content=native_installer_options_ja)

</details>

全機能を**3日間無料**で試せます。継続利用は**OSごとにUS$4.49の買い切り**で、適用される税金は決済時に処理されます。Mac版とWindows版は別購入です。直接ダウンロード版はCreem、Mac App Store版はAppleの購入手続きを利用します。

## Windowsでのインストール

1. `Klakk-1.4.1-Windows-Setup.exe`をダウンロードします。1つのインストーラーがARM64またはx64を自動で選び、必要なランタイムも含みます。
2. 現在のWindowsインストーラーは**未署名**です。Windowsの警告が表示された場合は、配布元を信頼できるか確認してから実行を判断してください。チェックサムはファイルの一致を確認するもので、発行者の署名の代わりにはなりません。
3. インストール後、Klakkを開きます。「一般」で「Klakkを有効にする」をオンにし、「オーディオ」で音源、音量、「出力デバイス」を選びます。「システムデフォルト」はWindowsの既定の出力を使います。
4. 普段使うアプリで文字を入力します。音が出ない場合は、[確認手順](guides/klakk-no-sound.ja.md)でWindowsの音量ミキサーと試用・購入状態も確認してください。

[Windows版のセットアップガイド](https://tryklakk.com/ja/blog/windows-keyboard-sounds-arm64-x64-setup/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

Scoopをすでに利用している場合は、[Klakk開発者が管理するWindowsバケット](packaging/scoop/README.ja.md)から公式サイト版1.4.1を導入できます。ネイティブx64・ARM64で導入、同じ版の再導入と削除を検証済みです。Scoopのmain・Extras公式カタログへの収録とは別の独自配布元です。

## Macでのインストール

1. `Klakk-1.4.1-23.dmg`をダウンロードして開きます。
2. Klakkを「アプリケーション」にドラッグし、そこにコピーしたアプリを開きます。
3. Klakkの案内に従い、「システム設定 → プライバシーとセキュリティ → 入力監視」でKlakkを許可します。macOSが求めた場合はアプリを終了して開き直します。
4. サウンドパックと音量を選び、普段使うアプリで入力します。

DMGにはDeveloper ID署名とAppleの公証を受けたKlakk 1.4.1（ビルド23）が入っています。入力監視は、ほかのアプリでのキー入力に合わせて音を再生するために使います。権限を許可する前に[Mac版のプライバシーポリシー](https://tryklakk.com/ja/privacy/)をご確認ください。

[Mac版のインストールガイド](https://tryklakk.com/ja/blog/mac-direct-download-install-guide/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

## 14種類のサウンドパック

両OSにCherry MX Black / Blue / Brown / Red（PBT）、Everglide Crystal Purple / Oreo、Gateron Black Ink / Browns / Reds — Revolt、Banana Split Lubed / Stock、NovelKeys Cream、Apex Pro TKL、Razer Blackwidow Eliteを収録しています。

[インストール前に試聴](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)できます。ブラウザの試聴はそのページ内だけで動作します。ほかのアプリで入力するときも音を鳴らすには、デスクトップ版をインストールしてください。追加の音を周囲に聞かせたくないときはヘッドホンを使います。

## ファイルの確認とサポート

保存したファイルを、選んだインストーラーの行と照合します。開く前に、バイト数とSHA-256の全桁を確認してください。ダウンロード完了の表示やファイル名の一致だけでは、この照合はできません。以下はKlakk開発者のLevinが管理する確認手順で、文章作成にはAIを補助的に使用しています。

### Klakk 1.4.1の公式ファイル

| ファイル | バイト数 | SHA-256 |
| --- | ---: | --- |
| `Klakk-1.4.1-Windows-Setup.exe` | 202233968 | `7a598cc3d3ea7236f377d7281a68a25a799c4f1772de9ce2a857d4c7658df454` |
| `Klakk-1.4.1-23.dmg` | 37897140 | `23c6b838f4e17e2ccddba1eb91927d0fe714403abcc512fca0545a013f5dfa51` |
| `Klakk-1.4.1-Windows-x64-Setup.exe` | 105364092 | `78cab2a64966ffa8d1c30e5d341980d2858e090ecd5f950a0faeea9ef163eb10` |
| `Klakk-1.4.1-Windows-arm64-Setup.exe` | 99090001 | `60bc18171d8b11988ea170b58fe5e038d8f7f6c1132e83b98a7d2f413b333a78` |

2026年10月11日に[公式1.4.1リリース](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1)の公開ファイルと照合した値です。Windows共通版はCPUを自動選択します。x64・ARM64専用版を選んだ場合は、それぞれの行で確認します。Mac公式サイト版は1.4.1（build 23）です。この表はMac App Store版の配布ファイルを示すものではありません。

### Windows：PowerShellで確認

保存先のフォルダーでPowerShellを開き、次のコマンドを使います。どちらもファイルを読み取るだけで、インストーラーは実行しません。

```powershell
(Get-Item -LiteralPath '.\Klakk-1.4.1-Windows-Setup.exe').Length
Get-FileHash -LiteralPath '.\Klakk-1.4.1-Windows-Setup.exe' -Algorithm SHA256 | Format-List Algorithm,Hash
```

1行目にバイト数、2行目にアルゴリズムとSHA-256の全桁が表示されます。x64版・ARM64版を選んだ場合や、ブラウザがファイル名を変更した場合は、2か所のファイル名を実際に保存した名前に置き換え、対応する行と比べてください。ファイル名を変えても、内容が同じならハッシュ値は変わりません。

### Mac：ターミナルで確認

DMGを保存したフォルダーで実行します。別の場所から確認する場合は、ファイル名を実際のフルパスに置き換えてください。

```sh
stat -f '%z' 'Klakk-1.4.1-23.dmg'
shasum -a 256 'Klakk-1.4.1-23.dmg'
```

1行目にバイト数、2行目にSHA-256とファイル名が表示されます。ハッシュの英字は大文字・小文字を区別せず、全桁を照合します。バイト数またはSHA-256が一致しないときは、開く前に選んだ版とファイル名を確認し、[公式リリース](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1)から取り直してください。チェックサムの一致は、開発者署名の代わりにはなりません。現在のWindowsインストーラーは未署名です。

[MicrosoftのGet-FileHash説明](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-5.1) · [共通Windows版とMac版のSHA256SUMS.txt](SHA256SUMS.txt) · [x64・ARM64専用版のSHA256SUMS-windows-native.txt](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/SHA256SUMS-windows-native.txt)

[サポート](https://tryklakk.com/ja/support/) · [利用規約](https://tryklakk.com/ja/terms/) · [Windows版のプライバシー](https://tryklakk.com/ja/windows/privacy/)

このリポジトリには公開ダウンロード案内を置いています。アプリのソースコードは含みません。GitHubが自動生成する「Source code」のZIP・tar.gzには配布案内、マニフェストと検証スクリプトが入ります。インストールには`.exe`または`.dmg`を選んでください。公開配布によってアプリがオープンソースになるわけではなく、製品の利用規約が適用されます。
