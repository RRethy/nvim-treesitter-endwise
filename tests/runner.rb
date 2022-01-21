require "tmpdir"

ENDWISE_DIR = File.expand_path(File.join(__dir__, ".."))
BASE_INIT_LUA = File.join(ENDWISE_DIR, "tests", "init.lua")

def config(opts)
  @config = {
    extension: "rb",
    overrides: "",
  }.merge(opts)
end

def test(description, testcase)
  if @config.nil?
    return
  end

  input, expected = testcase.split("\n").partition { |line| line.start_with?('-') }
  input = "#{input.map { |line| line[1..] }.join("\n")}\n"
  expected = "#{expected.map { |line| line[1..] }.join("\n")}\n"

  Dir.mktmpdir do |dir|
    overrides = File.join(dir, "overrides.lua")
    File.write(overrides, @config[:overrides])
    input_fname = File.join(dir, "input.#{@config[:extension]}")
    File.write(input_fname, input)
    system("nvim", "-u", BASE_INIT_LUA, "-S", overrides, input_fname, "-c", "lua ExecuteCR()")
    got = File.read(input_fname)
    if got != expected
      puts "\e[31mFailed\e[0m: #{description}"
      puts "\e[34mGot\e[0m:", got.gsub(/\t/, "<tab>")
      puts "\e[34mExpected:\e[0m", expected.gsub(/\t/, "<tab>")
    else
      puts "\e[32mSuccess\e[0m"
    end
  end
end

Dir.glob("#{ENDWISE_DIR}/tests/endwise/*.rb").each do |fname|
  @config = nil
  eval(File.read(fname))
end
