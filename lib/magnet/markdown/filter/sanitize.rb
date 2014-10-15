require 'sanitize'
require 'magnet/markdown/filter'

class Magnet::Markdown::Filter::Sanitize < HTML::Pipeline::Filter
  RULE = {
    attributes: {
      'a' => [
        'href'
      ],
      'iframe' => %w(allowfullscreen frameborder height marginheight marginwidth scrolling src style width),
      'img' => [
        'src'
      ],
      'div' => %w(itemscope itemtype),
      'script' => %w(async src),
      all: [
        'abbr',
        'align',
        'alt',
        'border',
        'cellpadding',
        'cellspacing',
        'cite',
        'class',
        'color',
        'cols',
        'colspan',
        'datetime',
        'height',
        'hreflang',
        'id',
        'itemprop',
        'lang',
        'name',
        'tabindex',
        'target',
        'title',
        'width',
        :data
      ]
    },
    elements: %w(
      a b blockquote br code dd del div dl dt em font h1 h2 h3 h4 h5 h6 h7 h8 hr i img ins kbd li ol p pre q rp rt ruby s
      samp strike strong sub sup table tbody td tfoot th thead tr tt ul var
    ),
    protocols: {
      'a' => {
        'href' => [
          :relative,
          'http',
          'https'
        ]
      },
      'img' => {
        'src' => [
          :relative,
          'http',
          'https'
        ]
      }
    },
    remove_contents: [
      'script'
    ]
  }

  ALLOW_SCRIPT_RULE = RULE.dup.tap do |rule|
    rule[:elements] = RULE[:elements] + %w(iframe script)
    rule[:remove_contents] = []
  end

  def call
    ::Sanitize.node!(doc, rule)
    doc
  end

  def rule
    case
    when context[:sanitize_rule]
      context[:sanitize_rule]
    when context[:allow_script] == true
      ALLOW_SCRIPT_RULE
    else
      RULE
    end
  end
end
