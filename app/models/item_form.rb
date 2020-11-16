class ItemForm
  include ActiveModel::Model
  attr_accessor :name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price, :user_id, :tag, :images
  
  validates :images, :name, :description, :price, presence: true
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id
  end
  validates :price, numericality: { only_integer: true }
  validates :price, numericality: {
    greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'が入力範囲外です'
  }

  def save_item
    item = Item.create(
      name: @name, description: @description, category_id: @category_id, condition_id: @condition_id, 
      shipping_cost_id: @shipping_cost_id, prefecture_id: @prefecture_id, shipping_day_id: @shipping_day_id,
      price: @price, user_id: @user_id, images: @images
    )
    tags = tag.split(nil)
    tags.each do |tag|
      tag = Tag.where(name: tag).first_or_initialize
      tag.save
      ItemTag.create(item_id: item.id, tag_id: tag.id)
    end
  end

  def self.find_item(item_id)
    item = Item.find(item_id)
    ItemForm.new(
      name: item.name,
      description: item.description,
      category_id: item.category_id,
      condition_id: item.condition_id,
      shipping_cost_id: item.shipping_cost_id,
      prefecture_id: item.prefecture_id,
      shipping_day_id: item.shipping_day_id,
      price: item.price,
      images: item.images
    )
  end

  def update_item(item_id)
    item = Item.find(item_id)
    item.update(
      name: @name, description: @description, category_id: @category_id, condition_id: @condition_id, 
      shipping_cost_id: @shipping_cost_id, prefecture_id: @prefecture_id, shipping_day_id: @shipping_day_id,
      price: @price, images: @images
    )
    tags = tag.split(nil)
    tags.each do |tag|
      if !(Tag.find_by(name: tag))
        tag = Tag.create(name: tag)
        ItemTag.create(item_id: item.id, tag_id: tag.id)
      end
    end
  end
end
