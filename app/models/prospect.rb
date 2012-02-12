class Prospect < ActiveRecord::Base
  def subscribe
    h = Hominid::API.new('4d5460e70fba6abc2b50e4a2ecf1a18c-us4')
    h.list_subscribe('02b3780976', self.email, {'FNAME' => 'nil', 'LNAME' => 'nil'}, 'html', false, true, true, false)
  end
end
