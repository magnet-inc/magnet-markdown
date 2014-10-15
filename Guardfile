# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :test do
  watch(/^lib\/(.*)\.rb/)                              { |m| "test/lib/#{m[1]}_test.rb" }
  watch(/^test\/(.*)_test.rb/)
  watch(/^test\/test_helper.rb/)                       { 'test' }
end
