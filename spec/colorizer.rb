describe 'colorizer' do

  it "makes colors for the terminal" do
    %w(gray red green yellow blue purple cyan white).each_with_index do |color, i|
      MotionPrint::Colorizer.send(color.to_sym, '').should == "\e[1;#{30+i}m\e[0m"
    end
  end

  it "includes the passed value as a part of the colorized string" do
    MotionPrint::Colorizer.send(:blue, 'RubyMotion Rocks!').should == "\e[1;34mRubyMotion Rocks!\e[0m"
  end

  it 'colorizes symbols' do
    MotionPrint::Colorizer.send(:blue, :a_symbol).should == "\e[1;34ma_symbol\e[0m"
  end

  it 'turns passed objects into strings with .inspect' do
    [
      [1, 2, 3, 4],
      {rubymotion: "rocks!"},
      Time.now,
      Object.new,
      NSSet.new,
      4,
      12.0,
      true
    ].each do |tester|
      MotionPrint::Colorizer.send(:blue, tester).should == "\e[1;34m#{tester.inspect}\e[0m"
    end
  end

end

