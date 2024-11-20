require "./action"

module Lolcat
  struct Options
    property action : Action = Action::Lolcat
    property spread : Float64 = 3.0
    property freq : Float64 = 0.1
    property invert : Bool = false
    property force : Bool = false

    def initialize(@spread : Float64 = 3.0, @freq : Float64 = 0.1, @invert : Bool = false, @force : Bool = false)
    end
  end
end
