class Sort < ActiveHash::Base
  self.data = [
    { id: 1,  name: '並び替え', value: 'id desc' },
    { id: 2,  name: '価格の安い順', value: 'price asc' },
    { id: 3,  name: '価格の高い順', value: 'price desc' },
    { id: 4,  name: '出品の古い順', value: 'updated_at desc' },
    { id: 5,  name: '出品の古い順', value: 'updated_at desc' }
  ]
end