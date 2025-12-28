module Lolcat
  macro shard_value(key)
    {% shard_yml = read_file("#{__DIR__}/../../shard.yml") %}
    {% lines = shard_yml.lines.select(&.starts_with?(key + ":")) %}
    {% parts = lines[0].split(":") %}
    {{ parts[1..-1].join(":").strip.gsub(/^["']|["']$/, "") }}
  end

  VERSION    = shard_value("version")
  REPOSITORY = shard_value("repository")
end
