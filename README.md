# IIF

Parse IIF Financial Files

## Installation

Add this line to your application's Gemfile:

    gem 'iif'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iif

## Usage

    content = File.read('some_file.iif')
    parser = IIF::Parser.new(content: content)
    output = parser.sanitize_sections

## Contributing

1. Fork it ( http://github.com/zph/iif/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
