class Sold < ActiveHash::Base
  self.data = [
    { id: 1,  name: '販売中', value: true },
    { id: 2,  name: '売り切れ', value: false }
  ]
end
