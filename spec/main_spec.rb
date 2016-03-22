describe "motion_print gem" do

  it 'indents' do
    MotionPrint.indent_by(0).should == ''
    MotionPrint.indent_by(1).should == '  '
    MotionPrint.indent_by(2).should == '    '
    MotionPrint.indent_by(5).should == '          '
  end

  it 'picks a color based on a type symbol' do
    MotionPrint.colors[:date].should == :greenish
    MotionPrint.colors[:falseclass].should == :red
    MotionPrint.colors[:float].should == :blue
    MotionPrint.colors[:hash].should == :pale
    MotionPrint.colors[:method].should == :purpleish
    MotionPrint.colors[:nilclass].should == :red
    MotionPrint.colors[:fixnum].should == :blue
  end

  it 'forces a color no matter the type' do
    # Strings
    MotionPrint.logger("String", force_color: :blue).should == "\e[1;34m\"String\"\e[0m"
    MotionPrint.logger("String", force_color: :red).should == "\e[1;31m\"String\"\e[0m"

    # Arrays
    MotionPrint.logger([1, '2'], force_color: :purple).should == "[\n  \e[1;35m1\e[0m,\n  \e[1;35m\"2\"\e[0m\n]"

    # Hashes
    MotionPrint.logger({a: 'b', c: :d}, force_color: :white).should == "{\n  \e[1;37m:a\e[0m  \e[1;37m => \e[0m\e[1;37m\"b\"\e[0m,\n  \e[1;37m:c\e[0m  \e[1;37m => \e[0m\e[1;37m:d\e[0m\n}"

    # Symbols
    MotionPrint.logger(:a_symbol, force_color: :green).should == "\e[1;32m:a_symbol\e[0m"
  end

  it 'aligns strings properly' do
    MotionPrint.align('RubyMotion', 0, 0).should == 'RubyMotion'
    MotionPrint.align('RubyMotion', 5, 0).should == 'RubyMotion'
    MotionPrint.align('RubyMotion', 20, 0).should == 'RubyMotion          '
    MotionPrint.align('RubyMotion', 20, 1).should == '  RubyMotion          '
    MotionPrint.align('RubyMotion', 20, 2).should == '    RubyMotion          '
    MotionPrint.align('RubyMotion', 20, 5).should == '          RubyMotion          '
    MotionPrint.align('RubyMotion', 5, 2).should == '    RubyMotion'
    MotionPrint.align('RubyMotion', 0, 1).should == '  RubyMotion'
  end

  it 'outputs arrays properly' do
    # Numbers
    MotionPrint.logger([1, 2]).should == "[\n  \e[1;34m1\e[0m,\n  \e[1;34m2\e[0m\n]"
    # Strings
    MotionPrint.logger(['1', '2']).should == "[\n  \e[0;33m\"1\"\e[0m,\n  \e[0;33m\"2\"\e[0m\n]"
  end

  it 'outputs multidimensional arrays properly' do
    # Numbers and Strings
    MotionPrint.logger([1, 2, ['1', '2']]).should == "[\n  \e[1;34m1\e[0m,\n  \e[1;34m2\e[0m,\n  [\n    \e[0;33m\"1\"\e[0m,\n    \e[0;33m\"2\"\e[0m\n  ]\n]"
  end

  it 'outputs hashes properly' do
    MotionPrint.logger({a: 'a', b: 2}).should == "{\n  \e[0;36m:a\e[0m  \e[0;36m => \e[0m\e[0;33m\"a\"\e[0m,\n  \e[0;36m:b\e[0m  \e[0;36m => \e[0m\e[1;34m2\e[0m\n}"
  end

  it 'outputs hashes with arrays properly' do
    MotionPrint.logger({
      a: 'a',
      b: 2,
      c: [
        BigDecimal.new('4.4'),
        12,
        String
      ]
    }).should == "{\n  \e[0;36m:a\e[0m  \e[0;36m => \e[0m\e[0;33m\"a\"\e[0m,\n  \e[0;36m:b\e[0m  \e[0;36m => \e[0m\e[1;34m2\e[0m,\n  \e[0;36m:c\e[0m  \e[0;36m => \e[0m[\n    \e[1;34m4.4\e[0m,\n    \e[1;34m12\e[0m,\n    \e[1;33mString\e[0m\n  ]\n}"
  end

  it 'outputs numbers correctly' do
    MotionPrint.logger(42).should == "\e[1;34m42\e[0m"
  end

  it 'outputs classes correctly' do
    MotionPrint.logger(Array).should == "\e[1;33mArray\e[0m"
  end

  it 'outputs symbols correctly' do
    MotionPrint.logger(:symbol).should == "\e[0;36m:symbol\e[0m"
  end

  it 'outputs true/false correctly' do
    MotionPrint.logger(true).should == "\e[1;32mtrue\e[0m"
    MotionPrint.logger(false).should == "\e[1;31mfalse\e[0m"
  end

  it 'outputs string correctly' do
    MotionPrint.logger('boo!').should == "\e[0;33m\"boo!\"\e[0m"
  end

  it 'outputs string with newlines correctly' do
    MotionPrint.logger("a\nb\nc").should == "\e[0;33m\"a\\nb\\nc\"\e[0m"
  end

  it 'outputs string with newlines indented correctly' do
    MotionPrint.logger(["a\nb\nc"], indent_level: 2).should == "[\n    \e[0;33m\"a\\nb\\nc\"\e[0m\n  ]"
  end

  it 'outputs instance variables properly' do
    class Foo
      attr_accessor :bar1
      def initialize
        @bar1, @bar2 = 1, 2
      end
    end
    ivar = Foo.new
    # MotionPrint.logger(ivar).should == "\e[1;33mFoo\e[0m\n  \e[0;35m:@bar1\e[0m  \e[0;36m => \e[0m\e[0;37m1\e[0m\n  \e[0;36m:@bar2\e[0m  \e[0;36m => \e[0m\e[0;37m2\e[0m\n"
    MotionPrint.logger(ivar).start_with?("\e[1;33m#<Foo:0x").should == true
    MotionPrint.logger(ivar).end_with?(">\e[0m\n  \e[0;35m:@bar1\e[0m  \e[0;36m => \e[0m\e[0;37m1\e[0m\n  \e[0;36m:@bar2\e[0m  \e[0;36m => \e[0m\e[0;37m2\e[0m\n").should == true
  end

  it 'allows opt-in for NSLog behavior' do
    MotionPrint.nslog_enabled?.should == false
    MotionPrint.enable_nslog
    MotionPrint.nslog_enabled?.should == true
  end
end

