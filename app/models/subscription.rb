class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :email
  validates_presence_of :user_id
  
  attr_accessor :stripe_card_token
  
  def save_with_payment(user)
    user.plan_id = self.plan_id
    self.user_id = user.id
    self.email = user.email
    if valid?
      customer = Stripe::Customer.create(description: user.email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
      user.save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  def update_with_payment
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)
      customer.update_subscription(prorate: false, plan: self.plan_id)
      user = self.user
      user.plan_id = self.plan_id
      user.save
      save!
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
    end
    
  def change_payment(token)
    if valid?
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)
      customer.card = token
      customer.save
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end
end
