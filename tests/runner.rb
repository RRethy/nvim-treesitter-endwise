require "tmpdir"

ENDWISE_DIR = File.expand_path(File.join(__dir__, ".."))
BASE_INIT_LUA = File.join(ENDWISE_DIR, "tests", "init.lua")
CURSOR = "█"

def config(opts)
  @config = {
    extension: "rb",
    overrides: "",
    command: "ExecuteCR"
  }.merge(opts)
end

def get_cursor_pos(lines)
  row = nil
  col = nil
  lines.split("\n").each_with_index do |line, i|
    if line.include?(CURSOR)
      row = i
      col = line.index(CURSOR)
    end
  end
  return row, col
end

def test(description, testcase)
  return if ARGV.length > 0 && !description.include?(ARGV.first)

  input, expected = testcase.split("\n").partition { |line| line.start_with?('-') }
  input = "#{input.map { |line| line[1..] }.join("\n")}\n"
  expected = "#{expected.map { |line| line[1..] }.join("\n")}\n"

  Dir.mktmpdir do |dir|
    overrides = File.join(dir, "overrides.lua")
    File.write(overrides, @config[:overrides])
    input_fname = File.join(dir, "input.#{@config[:extension]}")
    crow, ccol = get_cursor_pos(input)
    input = input.gsub(CURSOR, "")
    File.write(input_fname, input)
    command = @config[:command]
    system("nvim", "--headless", "-u", BASE_INIT_LUA, "+#{crow+1}", "-S", overrides, input_fname, "-c", "lua #{command}(#{ccol-1})")
    got = File.read(input_fname)
    if got != expected
      puts ""
      puts "\e[31mFailed\e[0m: #{description}"
      puts "\e[34mInput\e[0m:", input.gsub(/\t/, "<tab>")
      puts "\e[34mGot\e[0m:", got.gsub(/\t/, "<tab>")
      puts "\e[34mExpected:\e[0m", expected.gsub(/\t/, "<tab>")
      puts "\e[31m======\e[0m"
    else
      print "\e[32m.\e[0m"
    end
  end
end

Dir.glob("#{ENDWISE_DIR}/tests/endwise/*.rb").each do |fname|
  @config = nil
  eval(File.read(fname))
end

puts ""
