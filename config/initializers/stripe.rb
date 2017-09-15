if Rails.env.production?
	Rails.configuration.stripe = {
		publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
		secret_key: ENV['STRIPE_SECRET_KEY']
	}
else
	Rails.configuration.stripe = {
		publishable_key: 'pk_test_oM0lH17PjKSb0jKCOdbOLy3k',
		secret_key: 'sk_test_kZRmniULPj9tDVh67uYpsNOc'
	}
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]