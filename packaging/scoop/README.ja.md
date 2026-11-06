# WindowsでKlakkをScoopからインストール

これは**Klakk開発者が管理する独自のScoopバケット**です。Scoopのmain・Extras公式カタログへの収録を意味しません。Windows 10/11のx64・ARM64に対応した公式アプリ**1.4.2**を導入できます。32ビットWindowsとScoopのグローバルインストールには非対応です。

両方のアーキテクチャで同じ**116.9 MB**の[公式インストーラー](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.2)を使います。セットアップがPCに合うネイティブ版を選びます。1.4.1のアーキテクチャ別パッケージは、元のリリースから引き続き入手できます。

このバケットは、**All buckets** を選んだ [Scoopの公開アプリ検索](https://scoop.sh/#/apps?q=Klakk&o=false)でも見つけられます。導入には、以下のコマンドで開発者のバケットを追加してください。

現在のWindowsインストーラーは**未署名**です。Scoopは公開SHA-256とファイルを照合しますが、ハッシュ確認は発行元署名の代わりにはなりません。[公式ファイルとチェックサム](../../README.md#verify-the-download)を確認し、信頼できるか判断してください。

## Scoopをすでに使っている場合

Klakkを終了します。手動や別のパッケージ管理ツールで導入したKlakkがある場合は、その方法で先にアンインストールしてください。このマニフェストは別のKlakk登録がある状態では停止します。

```powershell
scoop bucket add klakk https://github.com/levindong2026/klakk-downloads
scoop install klakk/klakk
```

Scoopは共通の公式インストーラーのハッシュを検証し、現在のWindowsアカウントでScoopのバージョンフォルダーへインストールします。マニフェストはWindowsのネイティブアーキテクチャに合わない指定を拒否します。Windowsのアンインストール登録を持つ方式で、ポータブル版ではありません。スタートメニューの **Klakk (Scoop)** から起動します。インストールだけではアプリは自動起動しません。

## 1.4.2の変更点

[1.4.2](https://github.com/levindong2026/klakk-downloads/releases/tag/v1.4.2)では、決済にPancakeを利用します。新規購入のWindows版ライセンスはWindows端末3台まで利用できます。購入後は**About**からリカバリーコードをコピーできます。

## 最初の音を確認

**General**でKlakkを有効にし、**Audio**で**14種類のサウンドパック**から選び、音量と**Output Device**を確認します。**System Default**はWindowsの既定の出力を使います。ほかのアプリで入力して確認してください。[音が出ないときのチェックリスト](../../guides/klakk-no-sound.ja.md)も参照できます。

公式サイトのWindows版は**初回起動から3日間試用**できます。継続利用は**Windows版をUS$6.99で買い切り**、Pancakeの決済画面で適用される税額が加算されます。新規購入のWindows版ライセンスはWindows端末3台まで利用できます。公式サイトのMac版とMac App Store版は別購入・別ライセンスです。Scoopから導入しても無料の新ライセンスは付かず、既存の試用期間もリセットされません。Windows版はキーイベントをローカルで処理して再生し、入力した文章や生のキーイベントは送信しません。仮名化した利用イベント、ライセンス確認と更新確認の通信は行います。設定はPC内に保存します。[Windows版のプライバシーポリシー](https://tryklakk.com/ja/windows/privacy/)をご確認ください。

[インストール前に試聴](https://tryklakk.com/ja/keyboard-sounds/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_ja) · [Windows版の詳細](https://tryklakk.com/ja/windows/?utm_source=github&utm_medium=referral&utm_campaign=scoop_bucket&utm_content=install_guide_ja)

## 更新・削除

操作前にKlakkを終了し、Scoopで導入したコピーはScoopで管理します。別のインストーラーを重ねて実行しないでください。

```powershell
scoop update klakk
scoop uninstall klakk
```

削除は公式アンインストーラーを実行し、Scoopのアプリファイルとショートカットを取り除きます。`%LOCALAPPDATA%\Klakk`の設定・ライセンス情報は保持します。アプリの削除は試用期間のリセットではありません。登録されたアンインストーラーが別のインストール先を指す場合は、そちらを削除せず停止します。

## 検証範囲

[Scoop検証ワークフロー](https://github.com/levindong2026/klakk-downloads/actions/workflows/scoop-package-validation.yml)では、Scoop公式スキーマ、公開済みの旧版からの更新、新規導入と削除をネイティブx64・ARM64環境で確認します。インストーラーの容量とSHA-256、導入後の実行ファイルのアーキテクチャ、14音源とスタートメニューも確認します。別のインストール先を保護する動作と、アプリデータ内のテスト用マーカーが残ることも確認します。

[2026年11月5日の検証](https://github.com/levindong2026/klakk-downloads/actions/runs/42089446872)では、ネイティブのx64とARM64で旧Scoop版から1.4.2への通常の更新、新規インストール、強制再インストール、アンインストールを確認し、Klakkの起動や決済は行っていません。

[2026年10月23日の検証](https://github.com/levindong2026/klakk-downloads/actions/runs/39960328980)は前の1.4.1リビジョンが対象です。Scoopのパッケージ検証には、音声の再生、実設定すべての保持、決済の確認は含まれません。

Klakk開発者の**Levin**がAIの支援を使って管理しています。アプリのソースコードは非公開のままです。[English](README.md) · [Scoop独自バケットの公式説明](https://github.com/ScoopInstaller/Scoop/wiki/Buckets)
