require 'test_helper'

class Magnet::MarkdownTest < Test::Unit::TestCase
  test :version do
    assert { Magnet::Markdown::VERSION == '0.0.1' }
  end
end
