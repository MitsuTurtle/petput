class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '犬' },
    { id: 2, name: '猫' },
    { id: 3, name: '哺乳類（犬・猫以外）' },
    { id: 4, name: '鳥類' },
    { id: 5, name: '爬虫類' },
    { id: 6, name: '両生類' },
    { id: 7, name: '魚類' },
    { id: 8, name: '節足動物' },
    { id: 9, name: 'その他の動物' }
  ]

  include ActiveHash::Associations
  has_many :photos
end
