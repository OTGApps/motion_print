describe 'string extensions' do

  it 'responds to .shellescape' do
    'A RubyMotion String'.respond_to?(:shellescape).should == true
  end

  it 'escapes a normal string' do
    'RubyMotion Rocks!'.shellescape.should == "'RubyMotion Rocks!'"
  end

  it 'shellescapse a directory path' do
    '/Library/RubyMotion/'.shellescape.should == "'/Library/RubyMotion/'"
  end

  it 'shellescapes a path with spaces' do
    '/Library/Application Support/'.shellescape.should == "'/Library/Application Support/'"
  end

  it 'shellescapes a path with single quotes' do
    "~/mrickert/Mark's Private Folder".shellescape.should == "'~/mrickert/Mark'\"'\"'s Private Folder'"
  end

  it 'shellescapes a path with double quotes' do
    "~/mrickert/\"Finance\" records/".shellescape.should == "'~/mrickert/\"Finance\" records/'"
  end

end
