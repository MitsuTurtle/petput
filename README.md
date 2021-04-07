# PetPut
ペット写真共有SNSです。
ペットの写真を共有したり、他の飼い主さんと交流することができます。


* アプリURL：https://www.petput.net/<br>
ヘッダーのゲストログインをクリックすることで、メールアドレスとパスワードを入力することなくログインできます。

* アプリGitHub：https://github.com/MitsuTurtle/petput

![c6ff0c08e5ea994b148921c8e923687c](https://user-images.githubusercontent.com/71766878/111303779-45da0880-8698-11eb-92df-dc754e6aeb69.jpg)

## :turtle:作者情報
Wantedly：https://www.wantedly.com/id/mitsuo3<br>
Twitter：https://twitter.com/MitsuTurtle<br>
Quiita：https://qiita.com/MitsuTurtle

## :turtle:制作背景
私には25年以上飼育しているカメがいます。表情や仕草で癒やしを与えてくれます。

<img src="https://i.imgur.com/uWiMge8.jpg" width="250px"><br>
そんなカメの
* 記録を残してあげたい
* かわいさを伝えたい

また
* 他のカメのかわいさも知りたい
* 他の飼い主さんと交流したい
* 他のペットの魅力も知りたい

との思いが私にはあります。  

ペットの飼い主さんには、きっと、同じ思いをもっている人がいるのではと思い、このたびペット写真共有SNSアプリ&ensp;**PetPut**&ensp;を作成することにしました。
投稿する人も閲覧する人も、ペットの癒やしから元気をもらえる、そんなアプリになればと思っています。

<br>

## :turtle:実装内容

<br>

### Docker
<img width="489" alt="864bb77939fe27c145cf62eb30a4d275" src="https://user-images.githubusercontent.com/71766878/113496304-4d702d00-9533-11eb-8b71-9fcbd9da61d0.png">

<br>

### コメント
<img src="https://user-images.githubusercontent.com/71766878/111304315-f0522b80-8698-11eb-809c-649b1932c4ef.gif" width="500px">

<br>

### いいね、フォロー、お気に入り
<img src="https://user-images.githubusercontent.com/71766878/111303426-d9f7a000-8697-11eb-876b-23591ab13f0a.gif" width="500px">

<br>

### ダイレクトメッセージ
<img src="https://user-images.githubusercontent.com/71766878/111303642-15926a00-8698-11eb-93ac-08f96199e934.gif" width="500px">

<br>

### お知らせ
<img src="https://user-images.githubusercontent.com/71766878/111303866-61ddaa00-8698-11eb-9edc-d68e2daf13cc.gif" width="500px">

<br>

### レスポンシブデザイン（改善中）
レスポンシブデザイン化を進めております。<br><br>
<img src="https://user-images.githubusercontent.com/71766878/111987472-9ea31880-8b52-11eb-9ee1-255e804ebdb9.png" width="500px">

<br>

### その他
ユーザー登録（devise）、検索、ハッシュタグ、カテゴリー（ransack）、ページネーション（kaminari）

<br>

## 使用技術一覧

* フロントエンド
    * HTML/CSS
    * JavaScript
* バックエンド
    * Ruby 2.6.5
    * Rails 6.0.3.4
    * MySQL 5.6.47
* インフラ
    * AWS（EC2/S3/ALB/Route53）
    * Nginx/Unicorn
* テスト
    * RSpec
* CI/CD
    * Capistrano
* バージョン管理
    * Git/GitHub
* ソースコードエディタ
    * VScode
* 開発環境
    * Docker/Docker Compose


## ER図
![petput](https://user-images.githubusercontent.com/71766878/111310672-b2590580-86a0-11eb-819a-c17cea40963d.png)

## 今後実装したい内容
* 無限スクロール<br>
jScrollで実装を試みましたがビューが崩れてしまいペンディング中です。かわりにページネーションを実装しました。<br>

* レスポンシブデザイン化を進める
* テストコード追記
* CircleCI（テスト、コード整形、デプロイの自動化）
* Vue.jsによる見た目の向上
