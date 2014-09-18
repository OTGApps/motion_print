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

  describe "CDQ Object Handling" do
    # Mock CDQ object
    before do
      class CDQManagedObject
        def log; end
      end
    end

    it 'handles CDQManagedObject printing' do
      MotionPrint.logger(CDQManagedObject.new).should == nil
    end
  end

end
