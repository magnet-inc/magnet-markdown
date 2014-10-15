require 'test_helper'

class Magnet::MarkdownTest < Test::Unit::TestCase
  def test_version
    assert { Magnet::Markdown::VERSION == '0.0.1' }
  end
end
