require 'rails-helper'

describe ProductsController, type: :controller do

	befoer do
		@user = FactoryGirl.create(:user)
		@admin = FactoryGirl.create(:admin)
		@product1 = FactoryGirl.create(:product, name: "Custom style", description: "Nice bike", color: "custom", price: "4000")
		@product2 = FactoryGirl.create(:product, name: "Unique style", description: "F*** bike", color: "unique", price: "3000")
		@product3 = FactoryGirl.create(:product, name: "Camouflage style", description: "Camouflage bike", color: "camouflage", price: "2000")
		@product4 = FactoryGirl.create(:product, name: "Stealth style", description: "stealth bike", color: "black", price: "1000")


	### GET index action
	describe 'GET #index' do

		context 'when GET index matches a search_term' do
			it 'display the search request for a product' do
				get :index, params: {q: 'Custom style'}
			end
		end
	end
	end
end