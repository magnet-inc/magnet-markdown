require 'gemoji'
require 'magnet/markdown/filter'

class Magnet::Markdown::Filter::Emoji < HTML::Pipeline::Filter
  def self.emojis
    Emoji.all.map(&:aliases).flatten.sort
  end

  def self.regexp_pattern
    @regexp_pattern ||= /:(?<name>#{ (emojis.map { |n| Regexp.escape(n) }).join('|') }):/xo
  end

  def self.img_tag
    '<img class="emoji" alt=":%{name}:" title=":%{name}:" style="width: 1em; height: 1em;" align="absmiddle" src="%{src}">'
  end

  def call
    doc.search('text()').each do |node|
      content = node.to_html
      next unless content.include?(':')
      next if has_ancestor?(node, %w(pre code tt))
      html = emojify(content)
      next if html == content
      node.replace(html)
    end
    doc
  end

  def validate
    needs :emoji_root
  end

  def emojify(html)
    html.gsub(self.class.regexp_pattern) do |_match|
      name = Regexp.last_match['name']
      self.class.img_tag % { name: name, src: src_url(name) }
    end
  end

  def src_url(emoji_name)
    File.join(context[:emoji_root], src_path(emoji_name))
  end

  def src_path(emoji_name)
    if context[:emoji_path]
      context[:emoji_path].sub(':filename', emoji_filename(emoji_name))
    else
      File.join('emoji', emoji_filename(emoji_name))
    end
  end

  def emoji_filename(emoji_name)
    Emoji.find_by_alias(emoji_name).image_filename
  end
end
