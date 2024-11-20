require "./action"

module Lolcat
  struct Options
    property action : Action = Action::Lolcat
    property spread : Float64 = 3.0
    property freq : Float64 = 0.1
    property force : Bool = false
  end
end
