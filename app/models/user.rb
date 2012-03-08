class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :invite_code, :plan_id, :city, :state, :zip_code, :address
  
  belongs_to :plan
  has_one :subscription
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  attr_accessible :tag_names
  attr_accessor :tag_names
  after_save :assign_tags
  
  def subscribe
    h = Hominid::API.new('4d5460e70fba6abc2b50e4a2ecf1a18c-us4')
    h.list_subscribe('ce50a4ab86', self.email, {'FNAME' => 'nil', 'LNAME' => 'nil'}, 'html', false, true, true, false)
  end
  
  def assign_tags
    if @tag_names
      self.tags = self.tags | @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name)
      end
    end
  end
  
  
end
