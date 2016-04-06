class UserInterface

  def initialize(spot)
    @spot = spot
    @previous_spot = nil
  end

  def get_spot
    @previous_spot = @spot
    @spot
  end

  def no_more_moves_allowed?
    @spot == @previous_spot
  end

  def error
    raise "Alex, please stop trying to hack my code"
  end
end
