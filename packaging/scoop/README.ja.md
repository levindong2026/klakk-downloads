# WindowsでKlakkをScoopからインストール

これは**Klakk開発者が管理する独自のScoopバケット**です。Scoopのmain・Extras公式カタログへの収録を意味しません。Windowsのネイティブアーキテクチャに合う公式1.4.1パッケージを使い、Windows 10/11のx64・ARM64に対応します。32ビットWindowsとScoopのグローバルインストールには非対応です。

Scoopは、両アーキテクチャを含む202.2 MBの共通インストーラーの代わりに、**x64用105.4 MB**または**ARM64用99.1 MB**を選びます。同じ版・同じアプリファイルで、選択したアーキテクチャだけをダウンロードします。容量は10進表記のMBで、ダウンロード時間や導入速度の測定値ではありません。

このバケットは、**All buckets** を選んだ [Scoopの公開アプリ検索](https://scoop.sh/#/apps?q=Klakk&o=false)でも見つけられます。導入には、以下のコマンドで開発者のバケットを追加してください。

現在のWindowsインストーラーは**未署名**です。Scoopは公開SHA-256とファイルを照合しますが、ハッシュ確認は発行元署名の代わりにはなりません。[公式ファイルとチェックサム](../../README.md#verify-the-download)を確認し、信頼できるか判断してください。

## Scoopをすでに使っている場合

Klakkを終了します。手動や別のパッケージ管理ツールで導入したKlakkがある場合は、その方法で先にアンインストールしてください。このマニフェストは別のKlakk登録がある状態では停止します。

```powershell
scoop bucket add klakk https://github.com/levindong2026/klakk-downloads
scoop install klakk/klakk
```

Scoopはアーキテクチャ別の公式インストーラーのハッシュを検証し、現在のWindowsアカウントでScoopのバージョンフォルダーへインストールします。マニフェストはWindowsのネイティブアーキテクチャに合わない指定を拒否します。Windowsのアンインストール登録を持つ方式で、ポータブル版ではありません。スタートメニューの **Klakk (Scoop)** から起動します。インストールだけではアプリは自動起動しません。

## 最初の音を確認

**General**でKlakkを有効にし、**Audio**で**14種類のサウンドパック**から選び、音量と**Output Device**を確認します。**System Default**はWindowsの既定の出力を使います。ほかのアプリで入力して確認してください。[音が出ないときのチェックリスト](../../guides/klakk-no-sound.ja.md)も参照できます。

公式サイトのWindows版は**初回起動から3日間試用**できます。継続利用は**Windows版をUS$4.49で買い切り**、Creem決済で適用される税額が加算されます。公式サイトのMac版とMac App Store版は別購入・別ライセンスです。Scoopから導入しても無料の新ライセンスは付かず、既存の試用期間もリセットされません。Windows版はキーイベントをローカルで処理して再生し、利用・設定情報やライセンスの通信も行います。[Windows版のプライバシーポリシー](https://tryklakk.com/ja/windows/privacy/)をご確認ください。

[インストール前に試聴](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_ja) · [Windows版の詳細](https://tryklakk.com/ja/windows/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_ja)

## 更新・削除

操作前にKlakkを終了し、Scoopで導入したコピーはScoopで管理します。別のインストーラーを重ねて実行しないでください。

```powershell
scoop update klakk
scoop uninstall klakk
```

削除は公式アンインストーラーを実行し、Scoopのアプリファイルとショートカットを取り除きます。`%LOCALAPPDATA%\Klakk`の設定・ライセンス情報は保持します。アプリの削除は試用期間のリセットではありません。登録されたアンインストーラーが別のインストール先を指す場合は、そちらを削除せず停止します。

## 検証範囲

[Scoop検証ワークフロー](https://github.com/levindong2026/klakk-downloads/actions/workflows/scoop-package-validation.yml)は、ネイティブx64・ARM64でそれぞれ実行します。Scoop公式JSONスキーマ、選択した公開ファイルと容量、実際の導入、実行ファイルのアーキテクチャ、14音源、スタートメニュー、別インストール保護、同じ版の強制再導入、設定保持と削除を対象とします。アプリを起動する検証ではありません。同じ版の再導入だけで将来の版への更新や全機器での音声再生が証明されるわけではなく、QAを顧客のダウンロード・新規インストールとして数えません。

Klakk開発者の**Levin**がAIの支援を使って管理しています。アプリのソースコードは非公開のままです。[English](README.md) · [Scoop独自バケットの公式説明](https://github.com/ScoopInstaller/Scoop/wiki/Buckets)
