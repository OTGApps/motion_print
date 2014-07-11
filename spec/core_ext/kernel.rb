describe "Kernel extension" do

  it 'provides a global "mp" function' do
    Kernel.respond_to?('mp:').should == true
  end

end
