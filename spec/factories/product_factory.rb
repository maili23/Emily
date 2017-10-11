FactoryGirl.define do
  sequence :name do |n|
		"Bike #{n}"
	end
	
	factory :product do
		name 
		description "Just a great bike"
		color "black"
		price "1000"		
	end
end