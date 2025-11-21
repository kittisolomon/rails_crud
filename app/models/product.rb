class Product < ApplicationRecord
    validates :name, presence: true, uniqueness: true, length: {minimum:6, maximum:255}

    validates :price, presence: true, numericality: {greater_than: 0}
 
    validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :description, length: { maximum: 500 }, allow_blank: true

    validates :sku, presence: true, uniqueness: true

    validates :instock, inclusion: { in: [true, false] }

    has_one_attached :image

    def self.search(query)
      where("name ILIKE :query OR sku ILIKE :query", query: "%#{query}%")
    end
end
