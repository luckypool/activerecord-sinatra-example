require "date"
class User < ActiveRecord::Base
  def age
    birthday = Date.parse(self.birthday.to_s)
    Date.today.year - birthday.year
  end
end
