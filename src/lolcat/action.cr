module Lolcat
  # Defines the possible actions that can be performed by the lolcat command.
  #
  # This enum is used to determine what operation should be executed
  # based on the command line arguments provided.
  enum Action : UInt8
    # Process and display text with rainbow colors (default action)
    Lolcat
    # Display the version information
    Version
    # Display the help message
    Help
  end
end
