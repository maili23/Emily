class Product < ApplicationRecord
	validates :name, presence: true
	validates :description, presence: true
	validates :color, presence: true
	validates :price, presence: true
	has_many :order
	has_many :comments

	def self.search(search_term)
  	Product.where("name LIKE ?", "%#{search_term}%")
	end

	def highest_rating_comment
  	comments.rating_desc.first
	end

	def lowest_rating_comment
		comments.rating_desc.last
	end

	def average_rating
  	comments.average(:rating).to_f
	end

	def views
		$redis.get("product:#{id}")	# this means to 'GET product no 1'	
	end

	def viewed!
		$redis.incr("product:#{id}") # this is equivalent to 'INC product:1'
	end
end
