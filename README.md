# motion_print

A RubyMotion pretty printer.

instead of using `p` or `puts`, use `mp` to log your debug values to the RubyMotion REPL.

## Examples:

```
mp "a string"
```
<span style="color:gold;">a string</span>

```
mp :some_symbol
```
<span style="color:limegreen;">:some_symbol</span>

```
mp [1, 'two', :three, 4.0]
```

[  
>  <span style="color:mediumblue;">1</span>,  
>  <span style="color:gold;">two</span>,  
>  <span style="color:limegreen;">:three</span>,  
>  <span style="color:mediumblue;">4.0</span>  
]

```
mp({a: 'a', b: "bee", c: 4})
```

{  
>  :a     => <span style="color:gold;">a</span>,  
>  :b     => <span style="color:gold;">bee</span>,  
>  :see   => <span style="color:mediumblue;">4</span>  
}


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'motion_print'
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
