class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :invite_code, :plan_id
  
  belongs_to :plan
  has_one :subscription
  
  def subscribe
    h = Hominid::API.new('4d5460e70fba6abc2b50e4a2ecf1a18c-us4')
    h.list_subscribe('ce50a4ab86', self.email, {'FNAME' => 'nil', 'LNAME' => 'nil'}, 'html', false, true, true, false)
  end
  
end
