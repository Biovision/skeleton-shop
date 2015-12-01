class Order < ActiveRecord::Base
  enum state: [:placed, :processing, :ready, :delivered, :rejected]
end
