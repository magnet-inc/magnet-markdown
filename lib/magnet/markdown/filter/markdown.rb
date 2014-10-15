require 'github/markdown'
require 'magnet/markdown/filter'

class Magnet::Markdown::Filter::Markdown < HTML::Pipeline::TextFilter
  def initialize(text, context = nil, result = nil)
    super
    @text = @text.gsub("\r", '')
  end

  def call
    html = GitHub::Markdown.to_html(@text, :gfm)
    html.rstrip!
    html
  end
end
