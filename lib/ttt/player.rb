module TTT
  class Player

    attr_reader :marker, :name

    def initialize(name, marker, input = nil)
      @name = name
      @marker = marker
      @input = input
    end
  end
end
