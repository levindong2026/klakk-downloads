# WindowsでKlakkをScoopからインストール

これは**Klakk開発者が管理する独自のScoopバケット**です。Scoopのmain・Extras公式カタログへの収録を意味しません。Windowsのネイティブアーキテクチャに合う公式アプリ**1.4.1、内部リビジョン2026-10-11.1**を使います。アプリの表示バージョンは1.4.1のままで、内部リビジョンは更新された配布ファイルを識別します。Windows 10/11のx64・ARM64に対応し、32ビットWindowsとScoopのグローバルインストールには非対応です。

Scoopは、両アーキテクチャを含む116.9 MBの共通インストーラーの代わりに、**x64用61.1 MB**または**ARM64用58.0 MB**を選びます。現在の公式サイト版と同じアプリバージョン・内部リビジョンで、選択したアーキテクチャだけをダウンロードします。容量は10進表記のMBで、ダウンロード時間や導入速度の測定値ではありません。以前の1.4.1ファイルも保持されており、古い経路のパッケージと違うことだけで、現在の公式サイト版に問題があるとは判断できません。

このバケットは、**All buckets** を選んだ [Scoopの公開アプリ検索](https://scoop.sh/#/apps?q=Klakk&o=false)でも見つけられます。導入には、以下のコマンドで開発者のバケットを追加してください。

現在のWindowsインストーラーは**未署名**です。Scoopは公開SHA-256とファイルを照合しますが、ハッシュ確認は発行元署名の代わりにはなりません。[公式ファイルとチェックサム](../../README.md#verify-the-download)を確認し、信頼できるか判断してください。

## Scoopをすでに使っている場合

Klakkを終了します。手動や別のパッケージ管理ツールで導入したKlakkがある場合は、その方法で先にアンインストールしてください。このマニフェストは別のKlakk登録がある状態では停止します。

```powershell
scoop bucket add klakk https://github.com/levindong2026/klakk-downloads
scoop install klakk/klakk
```

Scoopはアーキテクチャ別の公式インストーラーのハッシュを検証し、現在のWindowsアカウントでScoopのバージョンフォルダーへインストールします。マニフェストはWindowsのネイティブアーキテクチャに合わない指定を拒否します。Windowsのアンインストール登録を持つ方式で、ポータブル版ではありません。スタートメニューの **Klakk (Scoop)** から起動します。インストールだけではアプリは自動起動しません。

## この内部リビジョンで変わること

[公開済みの更新記録](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.1-r20261011.1)は、新規導入でサインイン時の起動を既定で有効にし、既に無効にした設定は保持すると説明しています。アプリの設定で無効にできます。3日間の試用中には、購入画面を開くための閉じられる案内を表示し、Check activationの横にRestore Purchaseのリンクを配置しています。これは公開されたアプリの変更内容であり、本リビジョンのScoop導入・更新を新たに検証した結果ではありません。

## 最初の音を確認

**General**でKlakkを有効にし、**Audio**で**14種類のサウンドパック**から選び、音量と**Output Device**を確認します。**System Default**はWindowsの既定の出力を使います。ほかのアプリで入力して確認してください。[音が出ないときのチェックリスト](../../guides/klakk-no-sound.ja.md)も参照できます。

公式サイトのWindows版は**初回起動から3日間試用**できます。継続利用は**Windows版をUS$4.49で買い切り**、Creem決済で適用される税額が加算されます。公式サイトのMac版とMac App Store版は別購入・別ライセンスです。Scoopから導入しても無料の新ライセンスは付かず、既存の試用期間もリセットされません。Windows版はキーイベントをローカルで処理して再生し、入力した文章や生のキーイベントは送信しません。仮名化した利用イベント、ライセンス確認と更新確認の通信は行います。設定はPC内に保存します。[Windows版のプライバシーポリシー](https://tryklakk.com/ja/windows/privacy/)をご確認ください。

[インストール前に試聴](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_ja) · [Windows版の詳細](https://tryklakk.com/ja/windows/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_ja)

## 更新・削除

操作前にKlakkを終了し、Scoopで導入したコピーはScoopで管理します。別のインストーラーを重ねて実行しないでください。

```powershell
scoop update klakk
scoop uninstall klakk
```

削除は公式アンインストーラーを実行し、Scoopのアプリファイルとショートカットを取り除きます。`%LOCALAPPDATA%\Klakk`の設定・ライセンス情報は保持します。アプリの削除は試用期間のリセットではありません。登録されたアンインストーラーが別のインストール先を指す場合は、そちらを削除せず停止します。

## 検証範囲

[Scoop検証ワークフロー](https://github.com/levindong2026/klakk-downloads/actions/workflows/scoop-package-validation.yml)は、ネイティブx64・ARM64別に、Scoop公式JSONスキーマ、選択した公開ファイルと容量、実際の導入、実行ファイルのアーキテクチャ、14音源、スタートメニュー、別インストール保護、同じ版の強制再導入、設定保持と削除の確認を定義しています。[以前の成功した検証](https://github.com/levindong2026/klakk-downloads/actions/runs/38083232203)は、当初の1.4.1アーキテクチャ別パッケージを対象としたものです。アプリを起動しておらず、本リビジョンへのScoop更新や実際の音声再生を証明する結果ではありません。

Scoopのパッケージバージョン**1.4.1.20261011.1**は、アプリ自身の表示・Windows登録の**1.4.1**、配布ファイルの内部リビジョン**2026-10-11.1**とは別の識別子です。[今回のネイティブ検証](https://github.com/levindong2026/klakk-downloads/actions/runs/39960328980)は候補コミット`26d789ba`を対象に実行され、2026年10月23日にx64・ARM64の両ジョブが成功しました。旧パッケージ1.4.1から通常の`Scoop update`処理による更新、更新後の`current`参照先、公開ファイルのサイズ・SHA-256、新規導入、別インストール保護、強制再導入、QA用データマーカーの保持、削除時の清掃と、この導入先に属する起動登録の残存がないことを確認しています。この実行はテスト対象の候補の検証結果であり、mainへの採用は実際のコミットと公開ファイルで別に確認します。

データ保持の実証は、アプリ用データ領域に置いた**QA用マーカー**に限ります。アプリは明示的に起動しておらず、チェック時点では実行中のプロセスがないことを確認しました。すべての実設定、音声再生、初回起動画面、試用案内や決済を検証した結果ではなく、全機器での動作も保証しません。QAのダウンロード・導入は顧客のダウンロード・新規インストールとして数えません。

Klakk開発者の**Levin**がAIの支援を使って管理しています。アプリのソースコードは非公開のままです。[English](README.md) · [Scoop独自バケットの公式説明](https://github.com/ScoopInstaller/Scoop/wiki/Buckets)
