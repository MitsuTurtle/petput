class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '犬' },
    { id: 3, name: '猫' },
    { id: 4, name: '鳥' },
    { id: 5, name: '魚' },
    { id: 6, name: '爬虫類' },
    { id: 7, name: '両生類' },
    { id: 8, name: '昆虫' },
    { id: 9, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :users

end