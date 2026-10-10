# Klakk — Windows・Mac向けキーボード音アプリ

Klakk開発者が管理する公式ダウンロードページです。普段のキーボードで文字を入力すると、Klakkが打鍵音を再生します。キーの感触や、キーボード自体が出す物理的な音は変わりません。

[English](README.md) · [公式サイト](https://tryklakk.com/ja/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads) · [ブラウザで音を試す](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

動画で聴きたい方は、[44秒の英語版サウンドプレビュー](https://www.youtube.com/watch?v=rkSXD7r3Dy4)をご覧ください。Gateron Red、Cherry MX Blue、Banana Split Stock の編集された音サンプルを紹介します。14種類すべての音はブラウザのデモで試せます。

インストール後に音が出ない場合は、[Windows・Mac の確認手順](guides/klakk-no-sound.ja.md)で、有効化、出力先、権限、試用・ライセンス状態を確認できます。

## Klakk 1.4.1をダウンロード

| OS | 動作環境 | インストーラー |
| --- | --- | --- |
| Windows | Windows 10 / 11、ARM64またはIntel/AMD x64。32ビット版Windowsには非対応 | [Windows版をダウンロード](https://downloads.tryklakk.com/Klakk-1.4.1-Windows-Setup.exe) |
| Mac | macOS 14以降、AppleシリコンまたはIntel Mac | [Mac版DMGをダウンロード](https://downloads.tryklakk.com/Klakk-1.4.1-23.dmg) |

[SHA-256チェックサム](SHA256SUMS.txt) · [公式サイトのダウンロード案内](https://tryklakk.com/ja/download/?utm_source=github&utm_medium=referral&utm_campaign=official_downloads)

通常の配布先に接続できない場合は、[公式GitHubリリース](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1)から入手できます：[Windowsインストーラー](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-Windows-Setup.exe) · [Mac DMG](https://github.com/levindong2026/klakk-downloads/releases/download/v1.4.1/Klakk-1.4.1-23.dmg)。両方の配布先でファイルとチェックサムは同一です。

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

ファイルサイズ、SHA-256、確認用コマンドは[英語版のチェックサム表](README.md#verify-the-download)またはリリースの`SHA256SUMS.txt`に記載しています。

[サポート](https://tryklakk.com/ja/support/) · [利用規約](https://tryklakk.com/ja/terms/) · [Windows版のプライバシー](https://tryklakk.com/ja/windows/privacy/)

このリポジトリには公開ダウンロード案内を置いています。アプリのソースコードは含みません。GitHubが自動生成する「Source code」のZIP・tar.gzには配布案内、マニフェストと検証スクリプトが入ります。インストールには`.exe`または`.dmg`を選んでください。公開配布によってアプリがオープンソースになるわけではなく、製品の利用規約が適用されます。
