require 'test_helper'

class Magnet::Markdown::ProcessorTest < Test::Unit::TestCase
  setup do
    @processor = Magnet::Markdown::Processor.new(@context)
  end

  test :markdown do
    @input = '# h1'
    assert { output == '<h1>h1</h1>' }
  end

  test :auto_link do
    @input = 'Google > http://google.com'
    assert { output.include?('Google &gt; <a href="http://google.com">http://google.com</a>') }
  end

  test :sanitize do
    @input = <<-EOS
<img src="http://localhost/img.png">

<script src="http://localhost/script.js"></script>
    EOS

    assert do
      output.include?('<img')
    end

    assert do
      !output.include?('<script')
    end

    @call_context = { allow_script: true }

    assert do
      output.include?('<script')
    end
  end

  test :img_maxwidth do
    @input = '![](http://localhost/img.png)'
    assert { output.include?('max-width') && output.include?('<img') }
  end

  test :emoji do
    @input = ':thumbsup:'
    assert { output.include?('<img') }
    assert { output.include?('/images/emoji') }
    @call_context = { emoji_root: 'http://static.emoji/' }
    assert { !output.include?('/images/emoji') && output.include?('http://static.emoji/emoji') }
    @call_context = { emoji_root: 'http://static.emoji/', emoji_path: 'images/emoji/:filename' }
    assert { output.include?('http://static.emoji/images/emoji/unicode/') }
  end

  private

  def result
    @processor.call(@input, @call_context)
  end

  def output
    result[:output].to_s
  end
end
