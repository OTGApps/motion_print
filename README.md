# motion_print

A RubyMotion pretty printer.

[![Gem Version](https://badge.fury.io/rb/motion_print.svg)](http://badge.fury.io/rb/motion_print)
[![Build Status](https://travis-ci.org/OTGApps/motion_print.svg)](https://travis-ci.org/OTGApps/motion_print)
[![Code Climate](https://codeclimate.com/github/OTGApps/motion_print/badges/gpa.svg)](https://codeclimate.com/github/OTGApps/motion_print)

instead of using `p` or `puts`, use `mp` to log your debug values to the RubyMotion REPL.

## Examples:

<small>Colors don't show up correctly on github, so these are just examples of what you can do with `motion_print`. Try it out for yourself to see the more colorful output!</small>

![screen shot](http://i.imgur.com/5l0v4dT.png)


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
gem 'motion_print', github: 'OTGApps/motion_print'
```

And then execute:

```bash
bundle
```

## Woah! This is great! How can I make my gem support `motion_print`?

`motion_print` supports other gems (or even your own classes in your project ) with an opt-in feature. All you have to do is implement the `motion_print` method in your class (with option `mp` and `options` arguments). You can see an example implementation of this [in the specs](https://github.com/OTGApps/motion_print/blob/master/spec/opt_in_spec.rb).

### Essentially:

```ruby
def MyCustomClass
  def motion_print(mp)
    # This will output in red!
    mp.colorize("Some Output Here!", :red)
  end
end
```

Here's CDQ's implementation:

```ruby
class CDQManagedObject
  def motion_print(mp, options)
    if respond_to? :attributes
      "OID: " + mp.colorize(oid.gsub('"',''), options[:force_color]) + "\n" + mp.l_hash(attributes, options)
    else
      # old colorless method, still more informative than nothing
      log
    end
  end
end
```

## Fancy Debugging Tips

Ruby comes with some great methods for method introspection.  These methods look great in motion_print.

`mp __method__` will echo the name of the method from which you called motion_print.

`mp caller` will trace back up the call stack, so you can see how a method got called.

You can force a color of the output if you want like this:

```ruby
mp "My String", force_color: :blue # This is usually yellow
```

## Roadmap

1. Add more core objects people want to output: `UIView`, `Struct`, etc. Please open an issue to make suggestions or just implement it yourself and send me a pull request!
2. Add common gem objects RMQ, ProMotion etc. (CDQ was added and supported)
3. ~~Test suite.~~

## What about awesome_print_motion?

I used to be a big fan of [awesome_print_motion](https://github.com/michaeldv/awesome_print_motion). Then I ran the Instruments allocations profiler on an app that had a big loop with lots of `ap` statements. You should have seen the graph increase exponentially over a few seconds. Then I took a look at the actual `awesome_print_motion` source code. It's basically a direct port of the `awesome_print` gem and just modified to "work" with RubyMotion. There's all kinds of core class extensions and crazy threading things going on... way too complex for my needs to output a pretty version of an object or hash or array.

That, coupled with the fact that the developer of awesome_print_motion doesn't seem responsive to [issues](https://github.com/michaeldv/awesome_print_motion/issues) or [pull requests](https://github.com/michaeldv/awesome_print_motion/pulls), I decided to roll my own debugging tool specifically written for RubyMotion development.

`awesome_print_motion` is 793 lines of code and extends `Array`, `Kernel`, `Class`, and `Object`, and is _not_ tested.

`motion_print` is 152 lines of code, adds one method each to `String`, and `Kernel`, and is _fully_ tested (run `rake spec` to see the tests pass).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contact

Mark Rickert ([http://otgapps.io](http://otgapps.io))

- [http://twitter.com/markrickert](http://twitter.com/markrickert)
- [mark@otgapps.io](mark@otgapps.io)

## License

motion_print is available under the MIT license. See the LICENSE file for more info.
