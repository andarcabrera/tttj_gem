module TTT
  class Player

    attr_reader :marker, :name, :ui

    def initialize(name, marker, ui = nil)
      @name = name
      @marker = marker
      @ui = ui
    end
  end
end
