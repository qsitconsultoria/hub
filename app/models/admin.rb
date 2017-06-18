class Admin < User
  include UserProfiled

  def units
    Unit.all
  end
end
