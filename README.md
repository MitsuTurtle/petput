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
| (avatar)    |        |                           |
| profile     | text   |                           |

### Association
- has_many :photos
- has_many :comments
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_many :votes, dependent: :destroy
- has_many :voted_photos, through: :votes, source: :photo
- has_many :favorites, dependent: :destroy
- has_many :favorite_photos, through: :favorites, source: :photo
- has_many :messages, dependent: :destroy
- has_many :entries, dependent: :destroy

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
- has_many :votes, dependent: :destroy
- has_many :voters, through: :votes, source: :user

## photo_hashtag_relations テーブル
| Column  | Type       | Options                        |
| --------| ---------- | ------------------------------ |
| photo   | references | null: false, foreign_key: true |
| hashtag | references | null: false, foreign_key: true |

### Association
belongs_to :photo
belongs_to :hashtag

## hashtags テーブル
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

## relationships テーブル
| Column | Type       | Options                           |
| -------| ---------- | --------------------------------- |
| user   | references | foreign_key: true                 |
| follow | references | foreign_key: { to_table: :users } |

### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'

## votes テーブル
| Column | Type       | Options                        |
| -------| ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| photo  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :photo

## favorites テーブル
| Column | Type       | Options                        |
| -------| ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| photo  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :photo

## Entries テーブル
| Column | Type       | Options                        |
| -------| ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :room

## Messages テーブル
| --------| ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |
| content | text       |                                |

### Association
- belongs_to :user
- belongs_to :room

## Rooms テーブル
| ---- | ------ | ----- |
| name | string |       |

### Association
- has_many :messages
- has_many :entries




