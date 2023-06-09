# UNI COMBO

[UNI COMBO](https://unicombohub.com/) はアンダーナイトインヴァース（通称 "UNI" ）という格闘ゲームのコンボ動画を共有するための Web アプリケーションです。ユーザーが自分のコンボ動画をアップロードし、他のユーザーはそれを見て新しいコンボを練習することができます。

URL: https://unicombohub.com/

# 機能

- 動画の投稿

- 投稿された動画を探しやすくするためのフィルター機能

- 投稿の評価機能(いいね機能)

- 投稿時のコマンド入力の簡易化(入力したい内容をボタンを押すことで入力し、長いコンボでも簡単に投稿できるように)

- 動画のループ、スピード変更（コンボを練習しやすいように動画をスローにしたり、ループすることができます。)

- コメントの投稿、削除機能

# 使用技術

- OS: WSL2 Ubuntu 22.04.1
- Ruby: 2.7.7
- Rails: 7
- Bootstrap
- DB: SQLite(開発環境)、Postgresql(本番環境)
- CI: Github Actions
- デプロイ: [Render.com](https://render.com/)
- 動画保存: AWS S3
- メール機能: AWS SES
- ドメイン管理: AWS Route 53
- テストフレームワーク：RSpec

# ER 図

![picture 1](images/36dd197b71edb6240990f2d9162605e9e54907ba886a82b3f88434bda43548ff.png)

# 開発の経緯

アンダーナイトインヴァースは私が中学生の頃から大好きなゲームです。最大の特徴は、コンボの長さで、それに比例してコンボの難易度や自由度も高いです。YouTube を見ると、上手なプレイヤーたちが独自のコンボをたくさん投稿しています。私はそこで、かっこいいコンボや難しいコンボの練習をするのが大好きですが、YouTube だと探したいコンボを見つけることが難しいため、このアプリケーションを作りました。このアプリケーションでは、ダメージやヒット数などでコンボをソートしたり、練習したいコンボを探しやすくするフィルター機能があります。

# 今後追加したい機能

- twitter でのシェア機能

- プロフィールページの充実

- タグ機能

- いいねやコメントの通知機能

- ランキング機能（カッコよさや面白さなどの部門分けなど）
