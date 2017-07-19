class StaticPagesController < ApplicationController
  
  def index
  end

  def landing_page
  	@products = Product.limit(3)
  end

  def thank_you
  @name = params[:name]
  @email = params[:email]
  @message = params[:message]
  ActionMailer::Base.mail(from: @email,
      to: 'maili23@web.de',
      subject: "A new contact form message from #{@name}",
      body: @message).deliver_now
end

def about
end

def contact
end

end
