require 'rails_helper'

describe Product do

	context "when the product has comments" do
		
		let(:product) { Product.create!(name: "Custom style") }
		let(:user) { User.create!(email: "maili23@web.de", password: "password") }

		before do
			product.comments.create!(rating: 1, user: user, body: "I/'ve seen better bikes!")
			product.comments.create!(rating: 3, user: user, body: "Room for improvements...")
			product.comments.create!(rating: 5, user: user, body: "Perfect is much worser that this! This bike is awesome...!")
		end

		it "returns the average rating of all comments" do
			expect(product.average_rating).to eq 3
		end

		it "is not valid without a name" do
			expect(Product.new(description: "Nice bike")).not_to be_valid
		end
	end
end