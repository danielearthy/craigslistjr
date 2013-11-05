class Post < ActiveRecord::Base
  belongs_to :users
  belongs_to :category
  def user
    User.find(self.user_id).name
  end
  def email
    User.find(self.user_id).email
  end
end
