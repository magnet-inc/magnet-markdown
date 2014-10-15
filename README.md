# Magnet::Markdown

Magent specified markdown processor. Inspired by [qiita-markdown](https://github.com/increments/qiita-markdown).

Default processors:

- `Magnet::Markdown::Filter::Markdown`: convert markdown to html
- `Magnet::Markdown::Filter::Sanitize`: whitelist sanitize user markup
- `HTML::Pipeline::Filter::ImageMaxWidthFilter`: link to full size image for large images
- `Magnet::Markdown::Filter::Emoji`: covert :emoji: to img elements

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'magnet-markdown'
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install magnet-markdown
```

## Usage

`Magnet::Markdown::Processor` provides markdown rendering:

```ruby
processor = Magnet::Markdown::Processor.new
processor.call(markdow)
# => {
#   output: '<h1>Example</h1> ...'
# }
```

### Options

- `emoji_root`: base url to link to emoji sprite
- `emoji_path`: url path to link to emoji sprite. `:filename` can be used as a placeholder for the sprite file name. If no `emoji_path` is set "emoji/:filename" is used.
- `allow_script`: Default false. If set true, Do not remove `script` elements.

## Contributing

1. Fork it ( https://github.com/magnet-inc/magnet-markdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
