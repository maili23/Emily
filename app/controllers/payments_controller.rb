class PaymentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@product = Product.find(params[:product_id])
		@user = current_user

		token = params[:stripeToken]
		# Create the charge on Stripe's servers - this will charge user's card
		begin
			charge = Stripe::Charge.create(
				amount: (@product.price*100).to_i, # amount in cents, again
				currency: "eur",
				source: token,
				description: params[:stripeEmail],
				receipt_email: params[:stripeEmail]
			)

			if charge.paid
				Order.create(
					product_id: @product.id,
					user_id: @user.id,
					total: @product.price
				)
				flash[:success] = "Your transaction was successfully."
			end

		rescue Stripe::CardError => e
			# The card has been declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Unfortunately, there was an error prcessing your payment: #{err[:message]}"
		end
		redirect_to product_path(@product)
	end
end
