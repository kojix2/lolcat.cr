require "./action"

module Lolcat
  struct Options
    property action : Action
    property spread : Float64
    property freq : Float64
    property offset : Float64
    property? animate : Bool
    property duration : Int32
    property speed : Float64
    property? invert : Bool
    property? force : Bool

    def initialize(
      @action = Action::Lolcat,
      @spread = 3.0,
      @freq = 0.1,
      @offset = rand * 256.0,
      @animate = false,
      @duration = 12,
      @speed = 20.0,
      @invert = false,
      @force = false,
    )
    end
  end
end
