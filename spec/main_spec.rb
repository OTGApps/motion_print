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
    1.should == 1
  end

  it 'outputs arrays properly' do
    1.should == 1
  end

  it 'outputs multidimensional arrays properly' do
    1.should == 1
  end

  it 'outputs hashes properly' do
    1.should == 1
  end

  it 'outputs hashes with arrays properly' do
    1.should == 1
  end

  it 'outputs numbers correctly' do
    1.should == 1
  end

  it 'outputs classes correctly' do
    1.should == 1
  end

  it 'outputs symbols correctly' do
    1.should == 1
  end

  it 'outputs true/false correctly' do
    1.should == 1
  end

  # ...

end
