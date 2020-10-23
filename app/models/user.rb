class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角文字を使用してください' } do
    validates :firstname
    validates :familyname
  end
  
  with_options presence: true, format: { with: /\A[ァ-ン]+\z/, message: '全角文字を使用してください' } do
    validates :firstname_kana
    validates :familyname_kana
  end

end