# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column      | Type   | Options                   |
| ------------| ------ | ------------------------- |
| nickname    | string | null: false, unique: true |
| email       | string | null: false               |
| password    | string | null: false               |

### Association

- has_many :photos
- has_many :comments

## photos テーブル

| Column      | Type       | Options                        |
| ------------| ---------- | ------------------------------ |
| (image)     |            |                                |
| caption     | text       | null: false                    |
| category_id | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :photo_hashtag_relations
- has_many :hashtags, through: :photo_hashtag_relations

## photo_hashtag_relations テーブル

| Column  | Type       | Options                        |
| --------| ---------- | ------------------------------ |
| photo   | references | null: false, foreign_key: true |
| hashtag | references | null: false, foreign_key: true |

### Association

belongs_to :photo
belongs_to :hashtag

## tags テーブル

| Column   | Type   | Options     |
| ---------| ------ | ----------- |
| hashname | string | null: false |

 ### Association

- has_many :photo_hashtag_relations
- has_many :photos, through: :photo_hashtag_relations

## comments テーブル
| Column | Type       | Options                        |
| -------| ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| photo  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :photo