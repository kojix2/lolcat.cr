require "./action"

module Lolcat
  # Configuration options for the lolcat colorization process.
  #
  # This struct holds all the parameters that control how text is colorized,
  # including color cycling speed, animation settings, and display options.
  struct Options
    # The action to perform (Lolcat, Version, or Help)
    property action : Action

    # Controls how far apart the colors are spread (higher = slower color change)
    property spread : Float64

    # Controls how quickly the colors cycle (higher = faster color change)
    property freq : Float64

    # Starting position in the color cycle (randomized by default)
    property offset : Float64

    # Whether to animate the colors (shifting rainbow effect)
    property? animate : Bool

    # Number of animation frames to display
    property duration : Int32

    # Animation speed (frames per second)
    property speed : Float64

    # Whether to use background colors instead of foreground colors
    property? invert : Bool

    # Whether to force color output even when not outputting to a TTY
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
