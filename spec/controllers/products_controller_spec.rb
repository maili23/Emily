require 'rails_helper'

describe ProductsController, type: :controller do

	before do
		@user = FactoryGirl.create(:user)
		@admin = FactoryGirl.create(:admin)
		@product1 = FactoryGirl.create(:product, name: "Custom style", description: "Nice bike", color: "custom", price: "4000")
		@product2 = FactoryGirl.create(:product, name: "Unique style", description: "F*** bike", color: "unique", price: "3000")
		@product3 = FactoryGirl.create(:product, name: "Camouflage style", description: "Camouflage bike", color: "camouflage", price: "2000")
		@product4 = FactoryGirl.create(:product, name: "Stealth style", description: "stealth bike", color: "black", price: "1000")


	### GET index action
	describe 'GET #index' do

		context 'when a GET request matches a search_term' do
			it 'displays the search request for a product' do
				get :index, params: {q: 'Custom style'}
				expect(assigns(:products)).to match_array([@product1])
				expect(response).to render_template('index')
			end
		end

		context 'when a GET request matches no search_term' do
			it 'displays all the products' do
				get :index
				expect(assigns(:products)).to.match_array([@product.all])
			end
		end
	end

	### GET show
	describe 'GET #show' do
		context 'when the GET show action is requested' do
			it 'renders the show template' do
				get :show, params: { id: @product1 }
				expect(response.status).to eq 200
				expect(response).to render_template('show')
			end
		end
	end

	### GET new
	describe 'GET #new' do
		context 'when the GET new is requested ' do
			it 'renders the new product template' do
				get :new
				expect(response).to redirect_to('new')
			end
		end
	end

	### POST create
	describe 'POST #create' do
		context 'when a new product is created successfully' do
			it 'save the product in the database' do
				before = Product.all.length
				post :create, params: { product: {name: "Test Bike", description: "just for testing", color: "green", price: "100"}}
				after = Product.all.length
				expect(response.status).to eq 302
				expect(response).to redirect_to('@product')
				expect(after).to eq (before + 1)
			end
		end
	
		context 'when a new product is not created successfully' do
			it 'the product is not saved in the database' do
				before = Product.all.length
				post :create, params: { product: {name: "Test Bike"}}
				after = Product.all.length
				expect(response.status).to eq 200
				expect(response).to redirect_to('@product.errors')
				expect(after).to eq before
			end
		end
	end

	### PATCH update
	describe 'PATCH #update' do
		context 'when a product is updated' do
			it 'saves the product to the database' do
				before = Product.all.length
				patch :update, params: { id: @product1.id, product: {name: "Homemade style"} }
				after = Product.all.length
				expect(response.status).to eq 302
				expect(response).to redirect_to('@product')
				expect(after).to eq before
			end
		end
	end

	### DELETE destroy
	describe 'DELETE #destroy' do
		context 'when a product is deleted' do
			it 'destroy the product' do
				delete :destroy, params: {id: @product.id }
				expect(response.status).to eq 302
			end
		end
	end
	end
end