require 'html/pipeline'
require 'magnet/markdown'
require 'magnet/markdown/filter'

class Magnet::Markdown::Processor
  DEFAULT_CONTEXT = {
    emoji_root: '/images'
  }.freeze

  DEFAULT_FILTERS = [
    Magnet::Markdown::Filter::Markdown,
    Magnet::Markdown::Filter::Sanitize,
    HTML::Pipeline::ImageMaxWidthFilter,
    Magnet::Markdown::Filter::Emoji
  ].freeze

  def initialize(context = nil)
    context ||= {}
    @context = DEFAULT_CONTEXT.merge(context)
  end

  def call(input, context = nil)
    HTML::Pipeline.new(filters, @context).call(input, context || {})
  end

  def filters
    @filters ||= DEFAULT_FILTERS.dup
  end
end
