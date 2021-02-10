class Category < ApplicationRecord
    has_and_belongs_to_many :promotions

    validates :name, :code, presence: true
    validates :code, uniqueness: true
end
