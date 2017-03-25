class UserRepository
  def all
    User.all
  end

  def find(id)
    User.find(id)
  end

  def new_entity(attrs = nil)
    User.new(attrs)
  end

  def save(user)
    user.save
  end

  def delete(user)
    user.destroy
  end
end
