class PriceRange < ActiveHash::Base
  self.data = [
    { id: 2,  name: '¥300〜¥1000', value: '300 1000' },
    { id: 3,  name: '¥1000〜¥5000', value: '1000 5000' },
    { id: 4,  name: '¥5000〜¥10000', value: '5000 10000' },
    { id: 5,  name: '¥10000〜¥30000', value: '10000 30000' },
    { id: 6,  name: '¥30000〜¥50000', value: '30000 50000' },
    { id: 7,  name: '¥50000〜¥100000', value: '50000 1000000' }
  ]
end
