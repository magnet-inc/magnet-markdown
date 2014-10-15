require 'html/pipeline'
require 'magnet/markdown'

class Magnet::Markdown::Processor
  DEFAULT_CONTEXT = {
    asset_root: '/images',
    gfm: true
  }.freeze

  DEFAULT_FILTERS = [
    HTML::Pipeline::MarkdownFilter,
    HTML::Pipeline::SanitizationFilter,
    HTML::Pipeline::ImageMaxWidthFilter,
    HTML::Pipeline::EmojiFilter
  ].freeze

  def initialize(context = {})
    @context = DEFAULT_CONTEXT.merge(context)
  end

  def call(input, context = {})
    HTML::Pipeline.new(filters, @context).call(input, context)
  end

  def filters
    @filters ||= DEFAULT_FILTERS.clone
  end
end
