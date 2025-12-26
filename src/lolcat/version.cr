module Lolcat
  VERSION  = {{ `shards version #{__DIR__}`.chomp.stringify }}
  REPOSITORY = {{ `crystal eval 'require "yaml"; File.open("#{__DIR__}/../../shard.yml"){|f| puts YAML.parse(f)["repository"]}'`.chomp.stringify }}
end
