require "./action"

module Lolcat
  struct Options
    property action : Action = Action::Lolcat
    property spread : Float64 = 3.0
    property freq : Float64 = 0.1
    # property seed : Int32 = 0
    # property animate : Bool = false
    # property duration : Float64 = 12
    # property speed : Float64 = 20.0
    # property invert : Bool = false
    # property truecolor : Bool = false
    property force : Bool = false
  end
end
