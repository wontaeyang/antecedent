class User < ActiveRecord::Base
  belongs_to :parent, polymorphic: true
end

class Customer < User
end

class User::Admin < User
end
