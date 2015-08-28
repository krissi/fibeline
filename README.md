# Fibeline

Pipelines using Fibers. Chain together a pipe of elements like in bash.
 
All of this cool stuff was done by Dave Thomas. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fibeline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fibeline

## Usage

Please see 

 * http://pragdave.me/blog/2007/12/30/pipelines-using-fibers-in-ruby-19/
 * http://pragdave.me/blog/2008/01/01/pipelines-using-fibers-in-ruby-19part-ii/
 
### Example
```ruby
require 'fibeline'

class Evens < Fibeline::GenericElement
  def process
    value = 0
    loop do
      output(value)
      value += 2
    end
  end
end

evens = Evens.new
tripler          = Fibeline::Transformer.new { |val| val * 3 }
incrementer      = Fibeline::Transformer.new { |val| val + 1 }
multiple_of_five = Fibeline::Filter.new { |val| val % 5 == 0 }

5.times do
  puts (evens | tripler | incrementer | multiple_of_five).resume
end
```

```ruby
find        = Fibeline::ProcessTransformer.new('find -type f')
to_pathname = Fibeline::Transformer.new { |s| Pathname(s) }
realpath    = Fibeline::Transformer.new(&:realpath)

puts (find | to_pathname | realpath).to_a
```

## Contributing

1. Fork it ( https://github.com/krissi/fibeline/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
