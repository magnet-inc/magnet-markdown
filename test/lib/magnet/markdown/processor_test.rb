require 'test_helper'

class Magnet::Markdown::ProcessorTest < Test::Unit::TestCase
  setup do
    @processor = Magnet::Markdown::Processor.new(@context || {})
  end

  test :markdown do
    @input = '# h1'
    assert { output == '<h1>h1</h1>' }
  end

  test :auto_link do
    @input = 'Google > http://google.com'
    assert { output.include?('<a href="http://google.com">http://google.com</a>') }
  end

  test :img_maxwidth do
    @input = '![](http://localhost/img.png)'
    assert { output.include?('max-width') && output.include?('<img') }
  end

  test :emoji do
    @input = ':thumbsup:'
    assert { output.include?('<img') }
  end

  private

  def result
    @processor.call(@input, @call_context || {})
  end

  def output
    result[:output].to_s
  end
end
