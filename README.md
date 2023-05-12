# UNI COMBO

[UNI COMBO](https://unicombohub.com/) はアンダーナイトインヴァース（通称　 UNI）という格闘ゲームのコンボ動画を共有するための Web アプリケーションです。ユーザーが自分のコンボ動画をアップロードし、他のユーザーと共有することができます。

URL: https://unicombohub.com/

# 機能

- 動画の投稿

- 投稿された動画を探しやすくするためのフィルター機能

- 投稿の評価機能(いいね機能)

- 投稿時のコマンド入力の簡易化(入力したい内容をボタンを押すことで入力し、長いコンボでも簡単に投稿できるように)

- 動画のループ、スピード変更（コンボを練習しやすいように動画をスローにしたり、ループすることができます。)

# 使用技術

- Ruby: 2.7
- Rails: 7
- Bootstrap
- DB: SQLite(開発環境)、Postgresql(本番環境)
- デプロイ: [Render.com](https://render.com/)
- 動画保存: AWS S3
- メール機能: AWS SES
- ドメイン管理: AWS Route 53

# DB 設計

![picture 1](images/36dd197b71edb6240990f2d9162605e9e54907ba886a82b3f88434bda43548ff.png)

# 開発の経緯

このゲームは私が中学生の頃から大好きなゲームです。このゲームの最大の特徴はコンボの長さです。また、それに比例してコンボの難易度や自由度も高いです。youtube を見ると上手い方々が独自のコンボをいくつも投稿しています。私はそこでかっこよかったり難しいコンボの練習をするのが大好きなのですが、youtube だと探したいコンボを都合よく見つけることが難しいためこのアプリケーションを作りました。このアプリケーションではダメージやヒット数などでコンボをソートしたり出来るフィルター機能で練習したいコンボを探しやすくなっています。

# 苦労したこと

一番苦労したのは AWS の SES を使ったメール機能です。ドメインを登録し、ホストゾーンにレコードを登録するのにかなり悩みました。
最初は Rails tutorial で学んだ MAILGUN を使っていましたが、開発初期に本番環境にデプロイしたときは使えていましたが、いろんな機能を作った後にユーザーの新規登録をしようとするとなぜか使えず、いろいろ試しましたが上手くいかずこれ以上時間をかけるなら他のサービスに切り替えようと思い Amazon SES に切り替えました。
