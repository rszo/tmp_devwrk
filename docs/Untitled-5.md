2025年6月9日、福岡からのご質問ありがとうございます。

VS Code Dev Containers、WSL2、React、TypeScriptの環境構築を**コマンドラインベース**で行いたいとのこと、承知いたしました。GUI操作を最小限に抑え、ターミナルで完結する手順を目指しましょう。

この方法でも、**Docker Desktop for Windowsのインストールは必須**です。なぜなら、WSL2内のDockerエンジンを直接利用する方法は公式サポート外で、安定性に欠けるためです。Docker Desktopをインストールすることで、VS CodeのDev Containers拡張機能がWSL2とシームレスに連携できます。

-----

### 前提条件 (コマンドラインでの確認・インストール)

1.  **Windows 10/11 (最新版)**
      * `winver` コマンドでバージョンを確認できます。
      * Windows Updateで最新の状態に保ってください。
2.  **WSL2 の有効化とLinuxディストリビューションのインストール**
      * 管理者権限のPowerShellで以下を実行し、WSL2を有効にします:
        ```powershell
        wsl --install # これでWSL2が有効化され、デフォルトのLinuxディストリビューション (Ubuntu) がインストールされます。
        # 特定のディストリビューションをインストールしたい場合 (例: Ubuntu 22.04 LTS):
        # wsl --install -d Ubuntu-22.04
        ```
      * インストール後、Linuxディストリビューションを起動し、ユーザー名とパスワードを設定します。
      * WSL2がデフォルトバージョンであることを確認:
        ```powershell
        wsl --set-default-version 2
        ```
      * インストールされているディストリビューションを確認:
        ```powershell
        wsl -l -v
        ```
3.  **Docker Desktop for Windows のインストール**
      * Docker Desktopのインストーラーをダウンロードします: [https://docs.docker.com/desktop/install/windows-install/](https://docs.docker.com/desktop/install/windows-install/)
      * コマンドラインからのサイレントインストールも可能ですが、GUIでのインストールが一般的です。
        ```powershell
        # ダウンロードしたインストーラーのパスを指定して実行
        # 例: Start-Process ".\Docker Desktop Installer.exe" -ArgumentList "install", "--accept-licenses" -Wait
        ```
      * インストール後、**必ずDocker Desktopを起動し、設定で「Use the WSL 2 based engine」が有効になっていることを確認してください。** (これはGUIでの確認・設定が必要になります。)
4.  **Visual Studio Code のインストール**
      * Choco (Chocolatey) を使っている場合は:
        ```powershell
        choco install vscode
        ```
      * Scoop を使っている場合は:
        ```powershell
        scoop install vscode
        ```
      * または、公式サイトからインストーラーをダウンロードしてインストールしてください。
5.  **VS Code 拡張機能のインストール**
      * 管理者権限ではないPowerShellまたはコマンドプロンプトで以下を実行します。
        ```powershell
        code --install-extension ms-vscode-remote.remote-containers
        code --install-extension ms-vscode-remote.remote-wsl
        # React/TypeScript開発に便利な拡張機能もインストール (VS Code Remote - WSL環境にインストールされる)
        code --install-extension dbaeumer.vscode-eslint
        code --install-extension esbenp.prettier-vscode
        code --install-extension ms-vscode.vscode-typescript-tslint-plugin
        code --install-extension pkief.material-icon-theme
        ```

-----

### Dev Containers 環境構築手順 (コマンドラインベース)

ここからは、VS CodeのGUI操作を最小限に抑え、コマンドラインとファイル編集を中心に進めます。

1.  **WSL2 環境へのプロジェクトフォルダの作成と移動**

      * PowerShellまたはコマンドプロンプトで、VS Codeを開く前にWSL2に入ります。
        ```powershell
        wsl # デフォルトのディストリビューションにログイン
        # または特定のディストリビューションにログイン
        # wsl -d Ubuntu-22.04
        ```
      * WSL2のLinuxターミナル内で、プロジェクト用のディレクトリを作成し、そこへ移動します。
        ```bash
        mkdir ~/my-react-ts-app
        cd ~/my-react-ts-app
        ```

2.  **Dev Container 設定ファイル (.devcontainer) の作成**

      * `devcontainer.json` を手動で作成します。
      * VS Codeを現在のディレクトリで開きます（まだDev Containerに接続しません）。
        ```bash
        code .
        ```
      * VS Codeが開き、WSL2上の`~/my-react-ts-app`が直接開かれている状態になります。（左下隅が「WSL: Ubuntu-22.04」などの表示）
      * VS Codeの左側のファイルエクスプローラーで、`my-react-ts-app`の直下に`.devcontainer`ディレクトリを作成します。
        ```bash
        # VS Codeのターミナル (WSL2内) で実行するか、別途WSL2ターミナルで実行
        mkdir .devcontainer
        ```
      * `.devcontainer`ディレクトリ内に `devcontainer.json` ファイルを作成し、以下の内容を貼り付けます。
        ```json
        // .devcontainer/devcontainer.json
        {
          "name": "React TypeScript Dev Container",
          "image": "mcr.microsoft.com/devcontainers/javascript-node:18", // Node.jsのバージョンは適宜変更
          "features": {
            "ghcr.io/devcontainers/features/node:1": {
              "version": "lts", // または "20", "22" など
              "nvmInstallArgs": "--default-npm",
              "installYarn": true // Yarnが必要なければ削除
            },
            "ghcr.io/devcontainers/features/common-utils:2": {
              "installZsh": true, // Zshが必要なければ削除
              "installOhMyZsh": true // Oh My Zshが必要なければ削除
            }
          },
          "customizations": {
            "vscode": {
              "extensions": [
                "dbaeumer.vscode-eslint",
                "esbenp.prettier-vscode",
                "ms-vscode.vscode-typescript-tslint-plugin",
                "streetsidesoftware.code-spell-checker",
                "shinnn.vscode-advanced-new-file"
              ],
              "settings": {
                "editor.formatOnSave": true,
                "[typescriptreact]": {
                  "editor.defaultFormatter": "esbenp.prettier-vscode"
                },
                "[typescript]": {
                  "editor.defaultFormatter": "esbenp.prettier-vscode"
                }
              }
            }
          },
          "postCreateCommand": "npm install", // または "yarn install"
          "forwardPorts": [3000, 5173, 4173], // React開発サーバーの一般的なポート
          "remoteUser": "node"
        }
        ```
      * ファイルを保存します (Ctrl+S)。

3.  **Dev Container への再接続 (コマンドライン)**

      * VS Codeのコマンドパレット (F1 または Ctrl+Shift+P) を開きます。
      * `Dev Containers: Reopen in Container` と入力し、選択します。
      * VS CodeがDev Containerのビルドを開始し、接続します。初回はイメージのダウンロードとビルドに時間がかかります。

4.  **React/TypeScript プロジェクトの初期化 (コンテナ内)**

      * Dev Containerに接続後、VS Codeの統合ターミナル (Ctrl+\`) を開きます。
      * このターミナルは既にコンテナ内で動作しています。
      * プロジェクトの作成コマンドを実行します。
          * **Create React App (CRA)** の場合:
            ```bash
            npx create-react-app . --template typescript --use-npm # または --use-yarn
            ```
          * **Vite** の場合 (推奨):
            ```bash
            npm create vite@latest . -- --template react-ts # または yarn create vite . --template react-ts
            ```
              * `.` を指定することで、現在のディレクトリにプロジェクトを初期化します。
      * プロジェクトの依存関係をインストールします (もし `postCreateCommand` で `npm install` が指定されていなければ)。
        ```bash
        npm install # または yarn install
        ```

5.  **開発サーバーの起動と確認**

      * Reactアプリケーションの開発サーバーを起動します。
        ```bash
        npm start # CRAの場合
        # または
        npm run dev # Viteの場合
        ```
      * ブラウザで `http://localhost:3000` (CRA) または `http://localhost:5173` (Viteのデフォルト) にアクセスし、アプリケーションが表示されることを確認します。Dockerが自動的にポートフォワーディングしてくれます。

-----

これで、コマンドラインと最小限のGUI操作で、WSL2上のDev Container内でReact/TypeScript開発環境を構築できました。

**ポイント:**

  * `code .` でWSL2のフォルダを開いてから、`.devcontainer`フォルダを手動で作成・編集し、その後「Reopen in Container」コマンドを実行するのが、コマンドラインベースで最も直接的な方法です。
  * `devcontainer.json` の `image` や `features` で、必要なNode.jsのバージョンや追加ツール（Yarn, Zshなど）を細かく指定できます。
  * `extensions` でVS Code拡張機能をコンテナ内に自動インストールさせることが、開発体験を向上させます。