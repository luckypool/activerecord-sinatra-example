require "date"
class User < ActiveRecord::Base
  validates :name, presence: true
  validates :birthday, format: { with: /\A\d{4}-\d{2}-\d{2}\z/}
  def age
    birthday = Date.parse(self.birthday.to_s)
    Date.today.year - birthday.year
  end
end
