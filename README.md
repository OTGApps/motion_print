# motion_print

A RubyMotion pretty printer.

[![Gem Version](https://badge.fury.io/rb/motion_print.svg)](http://badge.fury.io/rb/motion_print) [![Build Status](https://travis-ci.org/MohawkApps/motion_print.svg)](https://travis-ci.org/MohawkApps/motion_print) [![Code Climate](https://codeclimate.com/github/MohawkApps/motion_print.png)](https://codeclimate.com/github/MohawkApps/motion_print) 

instead of using `p` or `puts`, use `mp` to log your debug values to the RubyMotion REPL.

## Examples:

<small>Colors don't show up correctly on github, so these are just examples of what you can do with `motion_print`. Try it out for yourself to see the more colorful output!</small>

```ruby
mp "a string"

"a string"
```

```ruby
mp :some_symbol

:some_symbol
```

```
mp [1, 'two', :three, 4.0]

[
  1, 
  'two', 
  :three, 
  4.0
]
```

```ruby
mp({b: "bee", a: 'a', see: 4})

{
  a     => a, 
  b     => bee, 
  see   => 4
}
```

## Installation

Add this line to your application's Gemfile:

Stable:
```ruby
gem 'motion_print'
```

Bleeding Edge:
```ruby
gem 'motion_print', github: 'MohawkApps/motion_print'
```

And then execute:

```bash
bundle
```
## Roadmap

1. Add more core objects people want to output: `UIView`, `Struct`, etc. Please open an issue to make suggestions or just implement it yourself and send me a pull request!
2. Test suite.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
