crystal_doc_search_index_callback({"repository_name":"lolcat","body":"# lolcat\n\nCrystal implimentation of the [lolcat](https://github.com/busyloop/lolcat).\n\n- Animation is not supported yet.\n\n## Installation\n\nDownload from [GitHub Release]\n\nFrom source code:\n\n```\ngit clone https://github.com/kojix2/lolcat.cr\ncd lolcat.cr\nshards build --release\nmv bin/lolcat /usr/local/bin/ # or any directory in your PATH\n```\n\n## Usage\n\nCLI\n\n```\nlolcat README.md\n```\n\n```\nlolcat --help\n```\n\nAs a library\n\nSee [examples](examples/)\n\n## Development\n\nPurpose:\n\nThis project was created as a template or sample for creating a command line tool.\nIt uses only standard libraries and is very simple in its mechanics.\n\n## Contributing\n\nPull requests and issues are welcome.\n\n## License\n\nThe original lolcat is licensed under the BSD 3-Clause \"New\" or \"Revised\" License\nSo this project is also licensed under the same license.\n","program":{"html_id":"lolcat/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"locations":[],"repository_name":"lolcat","program":true,"enum":false,"alias":false,"const":false,"types":[{"html_id":"lolcat/Lolcat","path":"Lolcat.html","kind":"module","full_name":"Lolcat","name":"Lolcat","abstract":false,"locations":[{"filename":"src/cli.cr","line_number":3,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L3"},{"filename":"src/lolcat.cr","line_number":5,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat.cr#L5"},{"filename":"src/lolcat/action.cr","line_number":1,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/action.cr#L1"},{"filename":"src/lolcat/lol.cr","line_number":4,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/lol.cr#L4"},{"filename":"src/lolcat/options.cr","line_number":3,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L3"},{"filename":"src/lolcat/parser.cr","line_number":5,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/parser.cr#L5"},{"filename":"src/lolcat/version.cr","line_number":1,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/version.cr#L1"}],"repository_name":"lolcat","program":false,"enum":false,"alias":false,"const":false,"constants":[{"id":"VERSION","name":"VERSION","value":"{{ (`shards version /home/runner/work/lolcat.cr/lolcat.cr/src/lolcat`).chomp.stringify }}"}],"class_methods":[{"html_id":"cat(path:Path,spread:Float64=3.0,freq:Float64=0.1,offset:Float64|Nil=nil,invert:Bool=false,force:Bool=false):Nil-class-method","name":"cat","doc":"Print a file with rainbow colors\n\n- If offset is not provided, it will be random.\n- If force is true, it will force color output even if stdout is not a TTY.\n","summary":"<p>Print a file with rainbow colors</p>","abstract":false,"args":[{"name":"path","external_name":"path","restriction":"Path"},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"Float64"},{"name":"offset","default_value":"nil","external_name":"offset","restriction":"Float64 | ::Nil"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"Bool"},{"name":"force","default_value":"false","external_name":"force","restriction":"Bool"}],"args_string":"(path : Path, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64 | Nil = nil, invert : Bool = false, force : Bool = false) : Nil","args_html":"(path : Path, spread : Float64 = <span class=\"n\">3.0</span>, freq : Float64 = <span class=\"n\">0.1</span>, offset : Float64 | Nil = <span class=\"n\">nil</span>, invert : Bool = <span class=\"n\">false</span>, force : Bool = <span class=\"n\">false</span>) : Nil","location":{"filename":"src/lolcat.cr","line_number":15,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat.cr#L15"},"def":{"name":"cat","args":[{"name":"path","external_name":"path","restriction":"Path"},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"Float64"},{"name":"offset","default_value":"nil","external_name":"offset","restriction":"Float64 | ::Nil"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"Bool"},{"name":"force","default_value":"false","external_name":"force","restriction":"Bool"}],"return_type":"Nil","visibility":"Public","body":"offset_f64 = offset || (rand * 256.0)\noptions = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: force)\nFile.open(path) do |file|\n  Lolcat::Lol.lol_cat(file, options)\nend\n"}},{"html_id":"cat(input:String,spread:Float64=3.0,freq:Float64=0.1,offset:Float64|Nil=nil,invert:Bool=false,force:Bool=false):Nil-class-method","name":"cat","doc":"Print a string with rainbow colors\n\n- If offset is not provided, it will be random.\n- If force is true, it will force color output even if stdout is not a TTY.\n","summary":"<p>Print a string with rainbow colors</p>","abstract":false,"args":[{"name":"input","external_name":"input","restriction":"String"},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"Float64"},{"name":"offset","default_value":"nil","external_name":"offset","restriction":"Float64 | ::Nil"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"Bool"},{"name":"force","default_value":"false","external_name":"force","restriction":"Bool"}],"args_string":"(input : String, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64 | Nil = nil, invert : Bool = false, force : Bool = false) : Nil","args_html":"(input : String, spread : Float64 = <span class=\"n\">3.0</span>, freq : Float64 = <span class=\"n\">0.1</span>, offset : Float64 | Nil = <span class=\"n\">nil</span>, invert : Bool = <span class=\"n\">false</span>, force : Bool = <span class=\"n\">false</span>) : Nil","location":{"filename":"src/lolcat.cr","line_number":29,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat.cr#L29"},"def":{"name":"cat","args":[{"name":"input","external_name":"input","restriction":"String"},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"Float64"},{"name":"offset","default_value":"nil","external_name":"offset","restriction":"Float64 | ::Nil"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"Bool"},{"name":"force","default_value":"false","external_name":"force","restriction":"Bool"}],"return_type":"Nil","visibility":"Public","body":"offset_f64 = offset || (rand * 256.0)\noptions = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: force)\nLolcat::Lol.lol_cat(input, options)\n"}},{"html_id":"lol(input,spread:Float64=3.0,freq:Float64=0.1,offset:Float64|Nil=nil,invert:Bool=false,&):Nil-class-method","name":"lol","doc":"Get a rainbow string line by line\n\n- If offset is not provided, it will be random.\n\nExample:\n```\nLolcat.lol(\"Rainbow string\", invert: true) do |line|\n  print line\nend\n```\n","summary":"<p>Get a rainbow string line by line</p>","abstract":false,"args":[{"name":"input","external_name":"input","restriction":""},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"Float64"},{"name":"offset","default_value":"nil","external_name":"offset","restriction":"Float64 | ::Nil"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"Bool"}],"args_string":"(input, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64 | Nil = nil, invert : Bool = false, &) : Nil","args_html":"(input, spread : Float64 = <span class=\"n\">3.0</span>, freq : Float64 = <span class=\"n\">0.1</span>, offset : Float64 | Nil = <span class=\"n\">nil</span>, invert : Bool = <span class=\"n\">false</span>, &) : Nil","location":{"filename":"src/lolcat.cr","line_number":47,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat.cr#L47"},"def":{"name":"lol","args":[{"name":"input","external_name":"input","restriction":""},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"Float64"},{"name":"offset","default_value":"nil","external_name":"offset","restriction":"Float64 | ::Nil"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"Bool"}],"yields":1,"block_arity":1,"return_type":"Nil","visibility":"Public","body":"offset_f64 = offset || (rand * 256.0)\noptions = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: true)\nLolcat::Lol.lol(input, options) do |line|\n  yield line\nend\n"}}],"types":[{"html_id":"lolcat/Lolcat/Action","path":"Lolcat/Action.html","kind":"enum","full_name":"Lolcat::Action","name":"Action","abstract":false,"ancestors":[{"html_id":"lolcat/Enum","kind":"struct","full_name":"Enum","name":"Enum"},{"html_id":"lolcat/Comparable","kind":"module","full_name":"Comparable","name":"Comparable"},{"html_id":"lolcat/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"lolcat/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/lolcat/action.cr","line_number":2,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/action.cr#L2"}],"repository_name":"lolcat","program":false,"enum":true,"alias":false,"const":false,"constants":[{"id":"Lolcat","name":"Lolcat","value":"0_u8"},{"id":"Version","name":"Version","value":"1_u8"},{"id":"Help","name":"Help","value":"2_u8"}],"namespace":{"html_id":"lolcat/Lolcat","kind":"module","full_name":"Lolcat","name":"Lolcat"},"instance_methods":[{"html_id":"help?-instance-method","name":"help?","abstract":false,"location":{"filename":"src/lolcat/action.cr","line_number":5,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/action.cr#L5"},"def":{"name":"help?","visibility":"Public","body":"self == Help"}},{"html_id":"lolcat?-instance-method","name":"lolcat?","abstract":false,"location":{"filename":"src/lolcat/action.cr","line_number":3,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/action.cr#L3"},"def":{"name":"lolcat?","visibility":"Public","body":"self == Lolcat"}},{"html_id":"version?-instance-method","name":"version?","abstract":false,"location":{"filename":"src/lolcat/action.cr","line_number":4,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/action.cr#L4"},"def":{"name":"version?","visibility":"Public","body":"self == Version"}}]},{"html_id":"lolcat/Lolcat/CLI","path":"Lolcat/CLI.html","kind":"class","full_name":"Lolcat::CLI","name":"CLI","abstract":false,"superclass":{"html_id":"lolcat/Reference","kind":"class","full_name":"Reference","name":"Reference"},"ancestors":[{"html_id":"lolcat/Lolcat/Lol","kind":"module","full_name":"Lolcat::Lol","name":"Lol"},{"html_id":"lolcat/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"lolcat/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/cli.cr","line_number":4,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L4"}],"repository_name":"lolcat","program":false,"enum":false,"alias":false,"const":false,"included_modules":[{"html_id":"lolcat/Lolcat/Lol","kind":"module","full_name":"Lolcat::Lol","name":"Lol"}],"namespace":{"html_id":"lolcat/Lolcat","kind":"module","full_name":"Lolcat","name":"Lolcat"},"class_methods":[{"html_id":"debug:Bool-class-method","name":"debug","abstract":false,"location":{"filename":"src/cli.cr","line_number":7,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L7"},"def":{"name":"debug","return_type":"Bool","visibility":"Public","body":"@@debug"}},{"html_id":"debug=(debug:Bool)-class-method","name":"debug=","abstract":false,"args":[{"name":"debug","external_name":"debug","restriction":"Bool"}],"args_string":"(debug : Bool)","args_html":"(debug : Bool)","location":{"filename":"src/cli.cr","line_number":7,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L7"},"def":{"name":"debug=","args":[{"name":"debug","external_name":"debug","restriction":"Bool"}],"visibility":"Public","body":"@@debug = debug"}}],"constructors":[{"html_id":"new-class-method","name":"new","abstract":false,"location":{"filename":"src/cli.cr","line_number":12,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L12"},"def":{"name":"new","visibility":"Public","body":"_ = allocate\n_.initialize\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"html_id":"option:Options-instance-method","name":"option","abstract":false,"location":{"filename":"src/cli.cr","line_number":10,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L10"},"def":{"name":"option","return_type":"Options","visibility":"Public","body":"@option"}},{"html_id":"parser:Parser-instance-method","name":"parser","abstract":false,"location":{"filename":"src/cli.cr","line_number":9,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L9"},"def":{"name":"parser","return_type":"Parser","visibility":"Public","body":"@parser"}},{"html_id":"print_help-instance-method","name":"print_help","abstract":false,"location":{"filename":"src/cli.cr","line_number":40,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L40"},"def":{"name":"print_help","visibility":"Public","body":"lol_cat(parser.help_message, option)"}},{"html_id":"print_version-instance-method","name":"print_version","abstract":false,"location":{"filename":"src/cli.cr","line_number":36,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L36"},"def":{"name":"print_version","visibility":"Public","body":"puts(\"lolcat version #{Lolcat::VERSION}\")"}},{"html_id":"run-instance-method","name":"run","abstract":false,"location":{"filename":"src/cli.cr","line_number":17,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L17"},"def":{"name":"run","visibility":"Public","body":"begin\n  case option.action\n  when Action::Lolcat\n    run_lolcat\n  when Action::Version\n    print_version\n  when Action::Help\n    print_help\n  else\n    raise(ArgumentError.new(\"Invalid action: #{option.action}\"))\n  end\nrescue ex\n  handle_error(ex)\nend"}},{"html_id":"run_lolcat-instance-method","name":"run_lolcat","abstract":false,"location":{"filename":"src/cli.cr","line_number":32,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/cli.cr#L32"},"def":{"name":"run_lolcat","visibility":"Public","body":"lol_cat(ARGF, option)"}}]},{"html_id":"lolcat/Lolcat/Lol","path":"Lolcat/Lol.html","kind":"module","full_name":"Lolcat::Lol","name":"Lol","abstract":false,"locations":[{"filename":"src/lolcat.cr","line_number":6,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat.cr#L6"},{"filename":"src/lolcat/lol.cr","line_number":5,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/lol.cr#L5"}],"repository_name":"lolcat","program":false,"enum":false,"alias":false,"const":false,"constants":[{"id":"ANSI_ESCAPE","name":"ANSI_ESCAPE","value":"/((?:\\e(?:[ -\\/]+.|[\\]PX^_][^\\a\\e]*|\\[[0-?]*.|.))*)(.?)/m"}],"extended_modules":[{"html_id":"lolcat/Lolcat/Lol","kind":"module","full_name":"Lolcat::Lol","name":"Lol"}],"including_types":[{"html_id":"lolcat/Lolcat/CLI","kind":"class","full_name":"Lolcat::CLI","name":"CLI"}],"namespace":{"html_id":"lolcat/Lolcat","kind":"module","full_name":"Lolcat","name":"Lolcat"},"instance_methods":[{"html_id":"lol(input:String,options:Options,&)-instance-method","name":"lol","abstract":false,"args":[{"name":"input","external_name":"input","restriction":"String"},{"name":"options","external_name":"options","restriction":"Options"}],"args_string":"(input : String, options : Options, &)","args_html":"(input : String, options : <a href=\"../Lolcat/Options.html\">Options</a>, &)","location":{"filename":"src/lolcat/lol.cr","line_number":20,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/lol.cr#L20"},"def":{"name":"lol","args":[{"name":"input","external_name":"input","restriction":"String"},{"name":"options","external_name":"options","restriction":"Options"}],"yields":1,"block_arity":1,"visibility":"Public","body":"io = IO::Memory.new(input)\nlol(io, options) do |line|\n  yield line\nend\n"}},{"html_id":"lol(input:IO,options:Options,&)-instance-method","name":"lol","abstract":false,"args":[{"name":"input","external_name":"input","restriction":"IO"},{"name":"options","external_name":"options","restriction":"Options"}],"args_string":"(input : IO, options : Options, &)","args_html":"(input : IO, options : <a href=\"../Lolcat/Options.html\">Options</a>, &)","location":{"filename":"src/lolcat/lol.cr","line_number":27,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/lol.cr#L27"},"def":{"name":"lol","args":[{"name":"input","external_name":"input","restriction":"IO"},{"name":"options","external_name":"options","restriction":"Options"}],"yields":1,"block_arity":1,"visibility":"Public","body":"input.each_line(chomp: false).with_index do |line, index|\n  yield rainbow_line(line, index, options)\nend"}},{"html_id":"lol_cat(input:IO|String,options:Options)-instance-method","name":"lol_cat","abstract":false,"args":[{"name":"input","external_name":"input","restriction":"IO | String"},{"name":"options","external_name":"options","restriction":"Options"}],"args_string":"(input : IO | String, options : Options)","args_html":"(input : IO | String, options : <a href=\"../Lolcat/Options.html\">Options</a>)","location":{"filename":"src/lolcat/lol.cr","line_number":8,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/lol.cr#L8"},"def":{"name":"lol_cat","args":[{"name":"input","external_name":"input","restriction":"IO | String"},{"name":"options","external_name":"options","restriction":"Options"}],"visibility":"Public","body":"if options.force\n  Colorize.enabled = true\nelse\n  Colorize.on_tty_only!\nend\nlol(input, options) do |line|\n  print(line)\nend\n"}},{"html_id":"rainbow_color(offset:Float64,freq:Float64):Tuple(UInt8,UInt8,UInt8)-instance-method","name":"rainbow_color","abstract":false,"args":[{"name":"offset","external_name":"offset","restriction":"Float64"},{"name":"freq","external_name":"freq","restriction":"Float64"}],"args_string":"(offset : Float64, freq : Float64) : Tuple(UInt8, UInt8, UInt8)","args_html":"(offset : Float64, freq : Float64) : Tuple(UInt8, UInt8, UInt8)","location":{"filename":"src/lolcat/lol.cr","line_number":68,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/lol.cr#L68"},"def":{"name":"rainbow_color","args":[{"name":"offset","external_name":"offset","restriction":"Float64"},{"name":"freq","external_name":"freq","restriction":"Float64"}],"return_type":"::Tuple(UInt8, UInt8, UInt8)","visibility":"Public","body":"red = (((Math.sin((freq * offset) + 0)) + 1) * 127).to_u8\ngreen = (((Math.sin((freq * offset) + ((2 * Math::PI) / 3))) + 1) * 127).to_u8\nblue = (((Math.sin((freq * offset) + ((4 * Math::PI) / 3))) + 1) * 127).to_u8\n{red, green, blue}\n"}},{"html_id":"rainbow_line(line:String,index:Int32,options:Options):String-instance-method","name":"rainbow_line","abstract":false,"args":[{"name":"line","external_name":"line","restriction":"String"},{"name":"index","external_name":"index","restriction":"Int32"},{"name":"options","external_name":"options","restriction":"Options"}],"args_string":"(line : String, index : Int32, options : Options) : String","args_html":"(line : String, index : Int32, options : <a href=\"../Lolcat/Options.html\">Options</a>) : String","location":{"filename":"src/lolcat/lol.cr","line_number":35,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/lol.cr#L35"},"def":{"name":"rainbow_line","args":[{"name":"line","external_name":"line","restriction":"String"},{"name":"index","external_name":"index","restriction":"Int32"},{"name":"options","external_name":"options","restriction":"Options"}],"return_type":"String","visibility":"Public","body":"colored_line = String.build do |str|\n  char_position = 0\n  line.scan(ANSI_ESCAPE) do |match|\n    escape_sequence = match[1]?\n    character = match[2]?\n    if escape_sequence\n      str << escape_sequence\n    end\n    if character\n      offset = (options.offset + index) + (char_position / options.spread)\n      color = rainbow_color(offset, options.freq)\n      if options.invert\n        str << (character.colorize.back(*color))\n      else\n        str << (character.colorize.fore(*color))\n      end\n      char_position = char_position + 1\n    end\n  end\nend\ncolored_line\n"}}]},{"html_id":"lolcat/Lolcat/Options","path":"Lolcat/Options.html","kind":"struct","full_name":"Lolcat::Options","name":"Options","abstract":false,"superclass":{"html_id":"lolcat/Struct","kind":"struct","full_name":"Struct","name":"Struct"},"ancestors":[{"html_id":"lolcat/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"lolcat/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"lolcat/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/lolcat/options.cr","line_number":4,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L4"}],"repository_name":"lolcat","program":false,"enum":false,"alias":false,"const":false,"namespace":{"html_id":"lolcat/Lolcat","kind":"module","full_name":"Lolcat","name":"Lolcat"},"constructors":[{"html_id":"new(action:Lolcat::Action=Action::Lolcat,spread:Float64=3.0,freq:Float64=0.1,offset:Float64=rand*256.0,invert:Bool=false,force:Bool=false)-class-method","name":"new","abstract":false,"args":[{"name":"action","default_value":"Action::Lolcat","external_name":"action","restriction":"::Lolcat::Action"},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"::Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"::Float64"},{"name":"offset","default_value":"rand * 256.0","external_name":"offset","restriction":"::Float64"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"::Bool"},{"name":"force","default_value":"false","external_name":"force","restriction":"::Bool"}],"args_string":"(action : Lolcat::Action = Action::Lolcat, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64 = rand * 256.0, invert : Bool = false, force : Bool = false)","args_html":"(action : <a href=\"../Lolcat/Action.html\">Lolcat::Action</a> = <span class=\"t\">Action</span><span class=\"t\">::</span><span class=\"t\">Lolcat</span>, spread : Float64 = <span class=\"n\">3.0</span>, freq : Float64 = <span class=\"n\">0.1</span>, offset : Float64 = rand <span class=\"o\">*</span> <span class=\"n\">256.0</span>, invert : Bool = <span class=\"n\">false</span>, force : Bool = <span class=\"n\">false</span>)","location":{"filename":"src/lolcat/options.cr","line_number":12,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L12"},"def":{"name":"new","args":[{"name":"action","default_value":"Action::Lolcat","external_name":"action","restriction":"::Lolcat::Action"},{"name":"spread","default_value":"3.0","external_name":"spread","restriction":"::Float64"},{"name":"freq","default_value":"0.1","external_name":"freq","restriction":"::Float64"},{"name":"offset","default_value":"rand * 256.0","external_name":"offset","restriction":"::Float64"},{"name":"invert","default_value":"false","external_name":"invert","restriction":"::Bool"},{"name":"force","default_value":"false","external_name":"force","restriction":"::Bool"}],"visibility":"Public","body":"_ = allocate\n_.initialize(action, spread, freq, offset, invert, force)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"html_id":"action:Action-instance-method","name":"action","abstract":false,"location":{"filename":"src/lolcat/options.cr","line_number":5,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L5"},"def":{"name":"action","return_type":"Action","visibility":"Public","body":"@action"}},{"html_id":"action=(action:Action)-instance-method","name":"action=","abstract":false,"args":[{"name":"action","external_name":"action","restriction":"Action"}],"args_string":"(action : Action)","args_html":"(action : <a href=\"../Lolcat/Action.html\">Action</a>)","location":{"filename":"src/lolcat/options.cr","line_number":5,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L5"},"def":{"name":"action=","args":[{"name":"action","external_name":"action","restriction":"Action"}],"visibility":"Public","body":"@action = action"}},{"html_id":"force:Bool-instance-method","name":"force","abstract":false,"location":{"filename":"src/lolcat/options.cr","line_number":10,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L10"},"def":{"name":"force","return_type":"Bool","visibility":"Public","body":"@force"}},{"html_id":"force=(force:Bool)-instance-method","name":"force=","abstract":false,"args":[{"name":"force","external_name":"force","restriction":"Bool"}],"args_string":"(force : Bool)","args_html":"(force : Bool)","location":{"filename":"src/lolcat/options.cr","line_number":10,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L10"},"def":{"name":"force=","args":[{"name":"force","external_name":"force","restriction":"Bool"}],"visibility":"Public","body":"@force = force"}},{"html_id":"freq:Float64-instance-method","name":"freq","abstract":false,"location":{"filename":"src/lolcat/options.cr","line_number":7,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L7"},"def":{"name":"freq","return_type":"Float64","visibility":"Public","body":"@freq"}},{"html_id":"freq=(freq:Float64)-instance-method","name":"freq=","abstract":false,"args":[{"name":"freq","external_name":"freq","restriction":"Float64"}],"args_string":"(freq : Float64)","args_html":"(freq : Float64)","location":{"filename":"src/lolcat/options.cr","line_number":7,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L7"},"def":{"name":"freq=","args":[{"name":"freq","external_name":"freq","restriction":"Float64"}],"visibility":"Public","body":"@freq = freq"}},{"html_id":"invert:Bool-instance-method","name":"invert","abstract":false,"location":{"filename":"src/lolcat/options.cr","line_number":9,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L9"},"def":{"name":"invert","return_type":"Bool","visibility":"Public","body":"@invert"}},{"html_id":"invert=(invert:Bool)-instance-method","name":"invert=","abstract":false,"args":[{"name":"invert","external_name":"invert","restriction":"Bool"}],"args_string":"(invert : Bool)","args_html":"(invert : Bool)","location":{"filename":"src/lolcat/options.cr","line_number":9,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L9"},"def":{"name":"invert=","args":[{"name":"invert","external_name":"invert","restriction":"Bool"}],"visibility":"Public","body":"@invert = invert"}},{"html_id":"offset:Float64-instance-method","name":"offset","abstract":false,"location":{"filename":"src/lolcat/options.cr","line_number":8,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L8"},"def":{"name":"offset","return_type":"Float64","visibility":"Public","body":"@offset"}},{"html_id":"offset=(offset:Float64)-instance-method","name":"offset=","abstract":false,"args":[{"name":"offset","external_name":"offset","restriction":"Float64"}],"args_string":"(offset : Float64)","args_html":"(offset : Float64)","location":{"filename":"src/lolcat/options.cr","line_number":8,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L8"},"def":{"name":"offset=","args":[{"name":"offset","external_name":"offset","restriction":"Float64"}],"visibility":"Public","body":"@offset = offset"}},{"html_id":"spread:Float64-instance-method","name":"spread","abstract":false,"location":{"filename":"src/lolcat/options.cr","line_number":6,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L6"},"def":{"name":"spread","return_type":"Float64","visibility":"Public","body":"@spread"}},{"html_id":"spread=(spread:Float64)-instance-method","name":"spread=","abstract":false,"args":[{"name":"spread","external_name":"spread","restriction":"Float64"}],"args_string":"(spread : Float64)","args_html":"(spread : Float64)","location":{"filename":"src/lolcat/options.cr","line_number":6,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/options.cr#L6"},"def":{"name":"spread=","args":[{"name":"spread","external_name":"spread","restriction":"Float64"}],"visibility":"Public","body":"@spread = spread"}}]},{"html_id":"lolcat/Lolcat/Parser","path":"Lolcat/Parser.html","kind":"class","full_name":"Lolcat::Parser","name":"Parser","abstract":false,"superclass":{"html_id":"lolcat/OptionParser","kind":"class","full_name":"OptionParser","name":"OptionParser"},"ancestors":[{"html_id":"lolcat/OptionParser","kind":"class","full_name":"OptionParser","name":"OptionParser"},{"html_id":"lolcat/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"lolcat/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src/lolcat/parser.cr","line_number":6,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/parser.cr#L6"}],"repository_name":"lolcat","program":false,"enum":false,"alias":false,"const":false,"namespace":{"html_id":"lolcat/Lolcat","kind":"module","full_name":"Lolcat","name":"Lolcat"},"constructors":[{"html_id":"new-class-method","name":"new","abstract":false,"location":{"filename":"src/lolcat/parser.cr","line_number":11,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/parser.cr#L11"},"def":{"name":"new","visibility":"Public","body":"_ = allocate\n_.initialize\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"html_id":"help_message:String-instance-method","name":"help_message","abstract":false,"location":{"filename":"src/lolcat/parser.cr","line_number":9,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/parser.cr#L9"},"def":{"name":"help_message","return_type":"String","visibility":"Public","body":"@help_message"}},{"html_id":"help_message=(help_message:String)-instance-method","name":"help_message=","abstract":false,"args":[{"name":"help_message","external_name":"help_message","restriction":"String"}],"args_string":"(help_message : String)","args_html":"(help_message : String)","location":{"filename":"src/lolcat/parser.cr","line_number":9,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/parser.cr#L9"},"def":{"name":"help_message=","args":[{"name":"help_message","external_name":"help_message","restriction":"String"}],"visibility":"Public","body":"@help_message = help_message"}},{"html_id":"opt:Options-instance-method","name":"opt","abstract":false,"location":{"filename":"src/lolcat/parser.cr","line_number":7,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/parser.cr#L7"},"def":{"name":"opt","return_type":"Options","visibility":"Public","body":"@opt"}},{"html_id":"parse(args)-instance-method","name":"parse","doc":"Parses the passed *args* (defaults to `ARGV`), running the handlers associated to each option.","summary":"<p>Parses the passed <em>args</em> (defaults to <code>ARGV</code>), running the handlers associated to each option.</p>","abstract":false,"args":[{"name":"args","external_name":"args","restriction":""}],"args_string":"(args)","args_html":"(args)","location":{"filename":"src/lolcat/parser.cr","line_number":87,"url":"https://github.com/kojix2/lolcat.cr/blob/98895f32b16ce8691dce9aa61d8cac0be6911253/src/lolcat/parser.cr#L87"},"def":{"name":"parse","args":[{"name":"args","external_name":"args","restriction":""}],"visibility":"Public","body":"super(args)\n@opt\n"}}]}]}]}})