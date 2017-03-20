class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, on: :create

  def full_name
    "#{first_name} #{last_name}"
  end
end
