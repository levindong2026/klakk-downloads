# Klakk の音が出ないとき：Windows・Mac の確認手順

Klakk 開発者による公式案内です。2026年10月8日更新、Klakk 1.4.1 向け。

[English](klakk-no-sound.md) · [ダウンロードとチェックサム](../README.ja.md)

インストール後に入力音が鳴らない場合は、アプリの有効化、音量、出力先、バックグラウンドモード、試用・ライセンス状態を確認します。Mac では「入力監視」の許可も必要です。再インストールの前に、次の手順で設定を見直してください。

## 音を鳴らす場所を確認する

[ブラウザの試聴](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_ja)は、プレビュー画面内で動作します。ほかのアプリで入力するときも音を鳴らすには、デスクトップ版をインストールして起動します。

Klakk はスピーカーやヘッドホンから音を追加します。キーボード自体の打鍵音や感触は変わりません。追加の音を周囲に聞かせたくない場合は、ヘッドホンを使ってください。

## Windows の有効化と出力先を確認する

Windows 10 / 11 の ARM64 と Intel・AMD x64 に対応しています。共通インストーラーが適切なネイティブ版を選びます。32ビット版 Windows には対応していません。

1. Klakk を開き、「一般」で「Klakkを有効にする」をオンにします。
2. 「オーディオ」で音源を選び、Klakk の音量をゼロより大きくします。
3. 「オーディオ → 出力デバイス」で、接続中のスピーカーやヘッドホンを選びます。Windows の既定の出力を使う場合は「システムデフォルト」を選びます。
4. Windows の音量ミキサーで、Klakk がミュートされていないか確認します。Windows 11 は「設定 → システム → サウンド → 音量ミキサー」、Windows 10 はタスクバーの音量アイコンを右クリックして「音量ミキサー」を開きます。
5. メモ帳などのローカルアプリで短い文章を入力します。ヘッドホンを変えた場合は、Klakk の出力先も確認してください。

Klakk で特定の機器を選んだ場合、Windows の既定の出力を変更しても、Klakk は選択済みの機器へ出力することがあります。両方の設定を確認してください。システム側の操作は、[Microsoft のアプリ音声ガイド](https://support.microsoft.com/en-us/windows/hardware/audio/fix-app-audio-not-working-while-system-sounds-work-in-windows)も参照できます。

## Mac の入力監視とアプリの出力先を確認する

Mac 版は macOS 14 以降の Apple シリコン・Intel Mac に対応しています。

1. 「アプリケーション」にインストールした Klakk を開き、アプリで再生を有効にします。
2. 「システム設定 → プライバシーとセキュリティ → 入力監視」で Klakk を許可します。権限の変更後に macOS が求めた場合は、Klakk を終了して開き直します。
3. Klakk のオーディオ設定で音源を選び、アプリの音量をゼロより大きくします。
4. Klakk の出力デバイスを確認します。接続中のスピーカー・ヘッドホンを選ぶか、システムの既定の出力を選んで Mac 側の出力先と音量を確認します。
5. 普段使うローカルの文章作成アプリで入力します。ヘッドホンを接続・切断したときは、出力先をもう一度確認してください。

入力監視は、ほかのアプリでのキー入力に合わせて音を鳴らすために使います。操作方法は [Apple の入力監視ガイド](https://support.apple.com/guide/mac-help/control-access-to-input-monitoring-on-mac-mchl4cedafb6/mac)で確認できます。許可する前に [Mac 版のプライバシーポリシー](https://tryklakk.com/ja/privacy/)もお読みください。

## 音が小さくなった場合はバックグラウンドモードを確認する

「オーディオ」で「バックグラウンドモード」を一時的にオフにして、もう一度入力します。英語表示では「Background Mode」です。

有効にすると、Zoom や Spotify など、指定の会議・メディアアプリが起動している間、入力音の音量を下げます。判定するのはアプリの起動状態です。音楽を一時停止したり通話を終了したりしても、そのアプリを開いたままだと音量が下がることがあります。この動作を使いたい場合は、確認後にモードをオンに戻してください。

音が小さい原因はほかにもあります。ほかのアプリも無音の場合は、OS の出力先、音量、機器の接続を確認してください。

## 試用期間と購入した版を確認する

14種類の音源を、**初回起動から3日間**試せます。試用終了後の再生には、インストールした版の有効なライセンスが必要です。再インストールしても試用期間は再開しません。

| 使用している版 | 購入と有効化 |
| --- | --- |
| Windows 版 | Creem で US$4.49 の買い切りです。適用される税金は決済時に表示されます。購入済みの場合は「Klakkを購入 → 有効化を確認」を使います。「購入を復元」には、購入メールの Windows 用ライセンスキーを入力します。 |
| 公式サイト・Klakk の Homebrew tap から入手した Mac 版 | Creem で US$4.49 の買い切りです。適用される税金は決済時に表示されます。Mac の公式サイト版で購入・復元の操作を行います。 |
| Mac App Store 版 | Apple の購入・復元操作を使います。現在の地域別価格は Apple の購入画面で確認してください。 |

Windows 版、Mac の公式サイト版、Mac App Store 版はそれぞれ別ライセンスです。ひとつの版の購入で、ほかの版も有効になるわけではありません。詳細は [利用規約](https://tryklakk.com/ja/terms/)をご確認ください。

## 実行前にインストーラーを確認する

[公式配布ファイルと SHA-256](../README.md#verify-the-download)で、同じバージョン・ファイル名の値を確認します。保存先のフォルダーで記載のコマンドを実行し、出力されたハッシュ全体を公開値と比べます。16進数の英字は、大文字・小文字が違っていても同じ値です。

一致しない場合は実行せず、公式リリースから入手し直してください。チェックサムの一致は公開ファイルとの一致を示すもので、発行者の署名の代わりにはなりません。現在の Windows インストーラーは未署名です。Mac の DMG には Developer ID 署名と Apple の公証を受けたアプリが入っています。

## 解決しないときはサポートへ

[Klakk サポート](https://tryklakk.com/ja/support/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_ja)に、OS のバージョン、Klakk のバージョン、Windows のアーキテクチャまたは Mac のチップ、出力先、試用・購入状態、試した手順を伝えてください。

公開の報告には、ライセンスキー、購入メール、私的な入力内容を載せないでください。Klakk は入力した文章やキー入力の内容を送信しません。利用状況の分析とライセンス確認の通信は別です。[Windows 版](https://tryklakk.com/ja/windows/privacy/)・[Mac 版](https://tryklakk.com/ja/privacy/)のプライバシーポリシーに詳細を記載しています。

これから使う場合は、[まず音を試聴](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_ja)して、[使う OS を選んで無料体験を始めてください](https://tryklakk.com/ja/download/?utm_source=github&utm_medium=referral&utm_campaign=first_sound&utm_content=no_sound_guide_ja)。
