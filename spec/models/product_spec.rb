require 'rails_helper'

describe Product do

	context "when the product has comments" do
		
		let(:product) { Product.create!(name: "Custom style", description: "nice bike", color: "unique", price: "4000") }
		# let(:user) { User.create!(email: "maili23@web.de", password: "password") }
		user = FactoryGirl.build(:user)

		before do
			product.comments.create!(rating: 1, user: user, body: "I/'ve seen better bikes!")
			product.comments.create!(rating: 3, user: user, body: "Room for improvements...")
			product.comments.create!(rating: 5, user: user, body: "Perfect is much worser that this! This bike is awesome...!")
		end

		it "returns the average rating of all comments" do
			expect(product.average_rating).to eq 3
		end

		it "returns the lowest rating comment" do
			expect(product.lowest_rating_comment.rating).to eq 1
		end

		it "returns the highest rating comment" do
			expect(product.highest_rating_comment.rating).to eq 5
		end

		it "is not valid without a name" do
			expect(Product.new(description: "Nice bike")).not_to be_valid
		end
	end

	#This unit test I cannot get working....

	# context "when the product has no views" do
  #  product = FactoryGirl.create(:product)
  #
  # it "hits returns 0" do
  #   expect(product.views).to eq 0
  # end
  #
  # it "first view gives 1 hits" do
  #   expect(product.views).to eq "OK"
  #   expect(product.viewed!).to eq 1
  #  end
  # end

end