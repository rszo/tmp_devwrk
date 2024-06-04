WSL2とDev Containersを使って、React + Remix + TypeScriptの開発環境を構築する手順について説明します。

### 全体像

WSL2上でDocker Desktopを動かし、そのDockerコンテナをVS CodeのDev Containers機能で開発環境として利用します。これにより、WindowsホストOSの環境を汚さずに、安定した開発環境を構築できます。

### 前提条件

* Windows 10 バージョン2004以上 または Windows 11
* BIOSで仮想化が有効になっていること
* 十分なRAM (16GB以上推奨)
* 管理者権限

### 構築手順

#### 1. WSL2のインストールと設定

1.  **WSL2の有効化とLinuxディストリビューションのインストール:**
    管理者としてPowerShellを開き、以下のコマンドを実行します。
    ```powershell
    wsl --install
    ```
    これにより、WSL2が有効化され、デフォルトのUbuntuディストリビューションがインストールされます。
    もし特定のディストリビューションを指定したい場合は、`wsl --install -d <ディストリビューション名>`のように指定します（例: `wsl --install -d Ubuntu-22.04`）。

2.  **WSL2のアップデートと設定:**
    ```powershell
    wsl --update
    ```
    WSL2の設定ファイルを作成し、メモリやプロセッサの割り当てを調整します。
    ユーザープロファイルディレクトリ (`%USERPROFILE%`) に `.wslconfig` ファイルを作成し、以下の内容を記述します。
    ```ini
    [wsl2]
    memory=8GB  # 割り当てるメモリ量 (環境に合わせて調整)
    processors=4 # 割り当てるプロセッサ数 (環境に合わせて調整)
    swap=2GB
    localhostForwarding=true
    ```
    設定後、WSLをシャットダウンして再起動します。
    ```powershell
    wsl --shutdown
    ```

#### 2. Docker Desktopのインストールと設定

1.  **Docker Desktopのインストール:**
    Docker Desktopの公式サイトからインストーラーをダウンロードし、指示に従ってインストールします。インストール中に「WSL2バックエンドを使用する」オプションが有効になっていることを確認してください。

2.  **Docker DesktopのWSL統合設定:**
    Docker Desktopの設定を開き、「Resources」→「WSL Integration」で、使用するWSLディストリビューションが有効になっていることを確認します。

#### 3. VS Codeのインストールと拡張機能の追加

1.  **VS Codeのインストール:**
    VS Codeの公式サイトからインストーラーをダウンロードし、インストールします。

2.  **必要なVS Code拡張機能のインストール:**
    VS Codeを開き、以下の拡張機能をインストールします。
    * **Dev Containers**: これがDev Containers機能のコアです。
    * **WSL**: WSL内のファイルシステムへのアクセスや、WSL上のターミナルとの連携を強化します。
    * **ESLint**: TypeScriptのコード品質向上に役立ちます。
    * **Prettier - Code formatter**: コードのフォーマットを自動化します。
    * **Tailwind CSS IntelliSense (RemixでTailwind CSSを使用する場合)**: Tailwind CSSの補完機能を提供します。

#### 4. Dev Containers環境の構築 (Remix + React + TypeScript)

プロジェクトのルートディレクトリでDev Containersの設定ファイルを作成します。

1.  **プロジェクトフォルダの作成とVS Codeで開く:**
    Windowsのエクスプローラーで適当な場所にプロジェクトフォルダを作成し、VS Codeでそのフォルダを開きます。

2.  **Dev Containers設定ファイルの追加:**
    VS Codeのコマンドパレット (`Ctrl+Shift+P`) を開き、「Dev Containers: Add Dev Container Configuration Files...」を選択します。
    * 表示されるリストから「Node.js & TypeScript」などの適切なイメージを選択します。
    * もしRemixのテンプレートが用意されていればそれを選んでも良いですが、今回は汎用的なNode.js & TypeScriptを選択し、後でRemixを追加します。
    * 「Add Docker Compose file」を選択することもできます。より複雑な構成（例: データベースもコンテナで動かす場合）に適しています。今回はシンプルなDockerfileベースで進めます。

    これにより、`.devcontainer` フォルダが作成され、中に `devcontainer.json` と `Dockerfile` (または `docker-compose.yml`) が生成されます。

3.  **`devcontainer.json` の設定:**
    `devcontainer.json` はDev Containersの挙動を定義するファイルです。以下のように設定を調整します。

    ```json
    {
      "name": "Remix-React-TypeScript Project",
      "image": "mcr.microsoft.com/devcontainers/typescript-node:20", // Node.jsのバージョンを適宜変更
      // または "build": { "dockerfile": "Dockerfile" } を使用してカスタムイメージをビルド
      "forwardPorts": [3000, 5173], // Remixのポート (開発サーバーのポート)
      "postCreateCommand": "npm install && npx remix init", // コンテナ作成後に実行するコマンド
      "customizations": {
        "vscode": {
          "extensions": [
            "dbaeumer.vscode-eslint",
            "esbenp.prettier-vscode",
            "bradlc.vscode-tailwindcss" // Tailwind CSSを使用する場合
          ],
          "settings": {
            // VS Codeのプロジェクト固有の設定
            "editor.formatOnSave": true,
            "editor.defaultFormatter": "esbenp.prettier-vscode",
            "[typescriptreact]": {
              "editor.defaultFormatter": "esbenp.prettier-vscode"
            },
            "[typescript]": {
              "editor.defaultFormatter": "esbenp.prettier-vscode"
            }
          }
        }
      },
      "remoteUser": "node" // コンテナ内で使用するユーザー (イメージによって異なる場合があります)
    }
    ```

    * `image`: 使用するベースイメージを指定します。`mcr.microsoft.com/devcontainers/typescript-node:20` はNode.jsとTypeScriptがプリインストールされた便利なイメージです。
    * `forwardPorts`: ホストOSにフォワードするポートを指定します。Remixのデフォルト開発サーバーは通常 `3000` または Viteが使われている場合は `5173` (RemixのVite連携の場合) を使用します。
    * `postCreateCommand`: コンテナが作成された後に一度だけ実行されるコマンドです。ここで依存関係のインストール (`npm install` または `yarn install`) やRemixの初期化 (`npx remix init`) を行います。
    * `customizations.vscode.extensions`: このDev Container環境に自動的にインストールされるVS Code拡張機能を指定します。
    * `customizations.vscode.settings`: このDev Container環境に適用されるVS Codeの設定です。
    * `remoteUser`: コンテナ内で使用するユーザーを指定します。Node.jsイメージでは `node` が一般的です。

4.  **`Dockerfile` の設定 (もし`image`ではなく`build`を使う場合):**
    `image` プロパティではなく、カスタムの `Dockerfile` を使う場合は、以下のような内容になります。

    ```dockerfile
    # Dockerfile
    FROM mcr.microsoft.com/devcontainers/typescript-node:20

    # 作業ディレクトリを設定
    WORKDIR /home/node/workspace

    # 必要であれば、追加のパッケージをインストール
    # RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

    # ポートを公開 (オプション)
    EXPOSE 3000
    EXPOSE 5173
    ```

5.  **Remixプロジェクトの初期化:**
    まだプロジェクトが作成されていない場合は、`postCreateCommand`で`npx remix init`を実行するように設定しましたが、もしコンテナに入ってから手動で実行したい場合は以下のコマンドをターミナルで実行します。

    ```bash
    # プロジェクトフォルダのルートで実行
    npx create-remix@latest . --typescript --react --eslint --prettier
    # または npx remix init
    ```
    指示に従ってプロジェクトを作成してください。

#### 5. Dev Containerの起動

1.  **VS CodeでDev Containerを開く:**
    VS Codeのコマンドパレット (`Ctrl+Shift+P`) を開き、「Dev Containers: Reopen in Container」または「Dev Containers: Open Folder in Container...」を選択し、プロジェクトフォルダを選択します。

    VS CodeがDockerイメージをビルドし、コンテナを起動します。初回はイメージのダウンロードやビルドに時間がかかる場合があります。

2.  **ターミナルの確認:**
    Dev Containerが起動すると、VS Codeのターミナルがコンテナ内の環境に接続されます。ここで通常のLinuxコマンドやNode.js関連のコマンドを実行できます。

3.  **開発サーバーの起動:**
    ターミナルでRemixの開発サーバーを起動します。
    ```bash
    npm run dev
    ```
    これにより、通常 `http://localhost:3000` や `http://localhost:5173` でRemixアプリケーションが利用可能になります。VS Codeは自動的にポートフォワーディングを行うため、Windowsのブラウザからアクセスできます。

### その他のヒント

* **ファイル同期のパフォーマンス:** WSL2とDockerの組み合わせでは、WSL2のファイルシステム（Linux側）にプロジェクトを置くのがパフォーマンス上推奨されます。Windows側のファイルをWSL2やDockerコンテナにマウントすると、特にファイル変更監視（ホットリロードなど）のパフォーマンスが低下する場合があります。Remixでは`chokidar`の設定で`CHOKIDAR_USEPOLLING=true`を`.env`ファイルに追加することで、この問題が改善されることがあります。
* **VS Codeの拡張機能:** Dev Container内で使用したいVS Code拡張機能は、`devcontainer.json`の`customizations.vscode.extensions`に記述することで、自動的にインストールされます。
* **Docker Compose:** 複数のコンテナを連携させたい場合（例: フロントエンド、バックエンドAPI、データベースなど）、`docker-compose.yml` を使用して Dev Container を設定することを検討してください。
* **Gitの連携:** Gitはコンテナ内にインストールされているはずです。通常通りVS CodeのGit機能やターミナルからGitコマンドを使用できます。SSHキーを使用する場合は、`.devcontainer/Dockerfile` にSSHキーをコンテナにコピーする設定を追加するか、VS CodeのSSH Agent転送機能を利用することを検討してください。

この手順で、WSL2とDev Containersを用いたReact + Remix + TypeScriptの開発環境が構築できます。