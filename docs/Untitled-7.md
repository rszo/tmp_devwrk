

「React (pnpm/TypeScript/Next.js/Playwright/WSL2) 開発環境を公式が推奨する構成で構築する方法」についてですね。各技術要素の公式ドキュメントをベースに、推奨される構成で環境を構築する手順を説明します。

-----

## React (pnpm/TypeScript/Next.js/Playwright/WSL2) 開発環境構築ガイド

このガイドでは、以下の技術スタックを用いて、公式が推奨する構成でReact開発環境をWSL2上に構築する手順を説明します。

  * **WSL2**: Windows上でLinux環境を統合するためのMicrosoftの技術
  * **pnpm**: 高速でディスク効率の良いパッケージマネージャー
  * **TypeScript**: JavaScriptに静的型付けを追加する言語
  * **Next.js**: Reactフレームワーク。サーバーサイドレンダリング(SSR)や静的サイト生成(SSG)をサポート
  * **Playwright**: モダンなWebブラウザの自動化ライブラリ（E2Eテスト用）

### 1\. WSL2のセットアップ

WSL2のセットアップは、Microsoftの公式ドキュメントが最も正確で詳細です。

1.  **WSL の有効化**: 管理者としてPowerShellまたはWindows Terminalを開き、以下のコマンドを実行します。
    ```powershell
    wsl --install
    ```
    これにより、WSLが有効になり、デフォルトのLinuxディストリビューション（通常はUbuntu）がインストールされます。
2.  **WSL2への更新**: インストールされたLinuxディストリビューションがWSL2モードで動作していることを確認します。必要であれば、以下のコマンドで更新します。
    ```powershell
    wsl --set-default-version 2
    ```
3.  **Linuxディストリビューションの起動**: スタートメニューからインストールしたLinuxディストリビューション（例: Ubuntu）を起動し、ユーザー名とパスワードを設定します。

<!-- end list -->

  * **公式ドキュメント**: [WSL のインストール](https://learn.microsoft.com/ja-jp/windows/wsl/install)

### 2\. Node.js (with Corepack) および pnpm のインストール

WSL2内のLinuxディストリビューションにNode.jsとpnpmをインストールします。Node.jsのバージョン管理には`fnm`や`nvm`が一般的ですが、Next.jsの推奨バージョンに合わせ、今回は直接インストールする方法、または`fnm`を使う方法を推奨します。

#### 方法A: Corepackを利用してpnpmを有効化 (Node.js 16.10 以降)

Node.js 16.10以降では、Corepackがデフォルトで有効になっています。

1.  **Node.jsのインストール**: 公式のNodeSourceリポジトリからインストールするのが推奨されます。
    ```bash
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
    ```
    LTS版（長期サポート版）が推奨されます。Next.jsの要件も確認してください。
2.  **Corepackの有効化**:
    ```bash
    corepack enable
    ```
3.  **pnpmの有効化**: これにより、`package.json`で指定されたpnpmのバージョンが自動的に使用されます。
    ```bash
    pnpm setup
    ```
    これにより、pnpmの実行ファイルがPATHに追加されます。シェルを再起動するか、`. ~/.bashrc`などでPATHを再読み込みしてください。

<!-- end list -->

  * **pnpm公式ドキュメント**: [Installation](https://pnpm.io/installation)
  * **Node.js公式ドキュメント**: [Installing Node.js via package manager](https://github.com/nodesource/distributions/blob/master/README.md)

#### 方法B: fnm を利用してNode.jsを管理し、pnpmをインストール

`fnm`はRust製の軽量なNode.jsバージョンマネージャーです。

1.  **fnmのインストール**:
    ```bash
    curl -fsSL https://fnm.vercel.app/install | bash
    ```
    `.bashrc`や`.zshrc`に`eval "$(fnm env --use-on-cd)"`のような記述を追加するよう指示されるので、それに従ってください。
2.  **Node.jsのインストールと使用**:
    ```bash
    fnm install --lts
    fnm use --lts
    ```
    LTS版が推奨されます。
3.  **pnpmのインストール**:
    ```bash
    npm install -g pnpm
    ```

### 3\. Next.jsプロジェクトの作成

pnpmを使ってNext.jsプロジェクトを作成します。TypeScriptのテンプレートを使用します。

1.  **プロジェクトディレクトリへの移動**:

    ```bash
    cd ~/<your-preferred-directory>
    ```

2.  **Next.jsアプリケーションの作成**:

    ```bash
    pnpm create next-app my-next-app --typescript --eslint --tailwind --app --src-dir --import-alias "@/*"
    ```

      * `my-next-app`: プロジェクト名。任意の名前を指定してください。
      * `--typescript`: TypeScriptを有効にします。
      * `--eslint`: ESLintを有効にします。
      * `--tailwind`: Tailwind CSSを有効にします（任意ですが推奨）。
      * `--app`: App Routerを有効にします（Next.js 13以降の推奨）。
      * `--src-dir`: `src/`ディレクトリを使用します。
      * `--import-alias "@/*"`: `@/*`のエイリアスを設定します。

3.  **プロジェクトディレクトリへ移動**:

    ```bash
    cd my-next-app
    ```

4.  **開発サーバーの起動**:

    ```bash
    pnpm dev
    ```

    ブラウザで`http://localhost:3000`にアクセスし、Next.jsのウェルカムページが表示されることを確認してください。

<!-- end list -->

  * **Next.js公式ドキュメント**: [Getting Started](https://nextjs.org/docs/getting-started/installation)

### 4\. Playwrightのセットアップ

Next.jsプロジェクトにPlaywrightをインストールし、E2Eテスト環境をセットアップします。

1.  **Playwrightのインストール**: プロジェクトのルートディレクトリで以下のコマンドを実行します。

    ```bash
    pnpm add -D @playwright/test
    ```

2.  **Playwrightの初期設定**:

    ```bash
    pnpm playwright install
    ```

    これにより、Playwrightのブラウザがインストールされ、`playwright.config.ts`などの設定ファイルが生成されます。

3.  **E2Eテストの実行**:
    Playwrightは自動的に`e2e/`ディレクトリを作成し、サンプルテストを配置します。以下のコマンドでテストを実行できます。

    ```bash
    pnpm playwright test
    ```

    または、Next.jsの`package.json`に`test:e2e`スクリプトを追加します。

    ```json
    "scripts": {
      "dev": "next dev",
      "build": "next build",
      "start": "next start",
      "lint": "next lint",
      "test:e2e": "playwright test"
    }
    ```

    その後、`pnpm run test:e2e`で実行します。

<!-- end list -->

  * **Playwright公式ドキュメント**: [Getting started](https://playwright.dev/docs/intro)

### 5\. VS Codeのセットアップ (WSL2連携)

VS CodeはWSL2環境での開発に最適化されています。

1.  **VS Codeのインストール**: WindowsにVS Codeをインストールします。
2.  **Remote - WSL拡張機能のインストール**: VS Codeを起動し、拡張機能マーケットプレイスで「Remote - WSL」を検索してインストールします。
3.  **WSL2プロジェクトを開く**:
      * WSL2のターミナルで、プロジェクトのルートディレクトリに移動します。
      * `code .`と入力してEnterを押すと、VS CodeがWSL2環境でプロジェクトを開きます。
      * または、VS Codeの「ファイル」\>「フォルダーを開く」から、WSL2上のパス（例: `\\wsl$\Ubuntu\home\<username>\my-next-app`）を指定して開きます。

これにより、VS CodeがWSL2のファイルシステムと直接連携し、Linux環境で実行されているNode.jsやpnpm、TypeScriptのLanguage Serverなどが利用できるようになります。

### その他の推奨事項

  * **Gitのインストール**: WSL2内でGitをインストールし、バージョン管理を行います。
    ```bash
    sudo apt update
    sudo apt install git
    ```
  * **ESLint/Prettierの設定**: Next.jsのプロジェクト作成時にESLintは有効になりますが、Prettierと連携してコードフォーマットを自動化することを強く推奨します。
      * VS Codeの拡張機能「Prettier - Code formatter」をインストール。
      * プロジェクトのルートに`.prettierrc`ファイルを作成し、好みの設定を記述。
      * VS Codeの設定で「Format On Save」を有効にする。
  * **Dockerの利用**: データベースや他のサービスを開発環境に含める場合、WSL2と連携できるDocker Desktop for Windowsの利用が便利です。

-----

このガイドは、各ツールの公式ドキュメントに基づいた推奨される構成を提供します。各ツールの最新情報や詳細な設定については、それぞれの公式ドキュメントをご参照ください。

