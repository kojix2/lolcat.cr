module Lolcat
  # The current version of the lolcat program.
  #
  # This constant is automatically set to the version specified in shard.yml
  # using a macro that runs the `shards version` command at compile time.
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end
