class Product < ApplicationRecord
	has_many :order

	def self.search(search_term)
  	Product.where("name LIKE ?", "%#{search_term}%")
	end

end
