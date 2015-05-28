class SimpleMotionPrint

  def motion_print
    'SimpleMotionPrint'
  end

end


class CustomMotionPrint

  def motion_print(mp)
    mp.colorize('CustomMotionPrint', :cyanish)
  end

end


class IndentedMotionPrint

  def motion_print(mp, options)
    mp.logger(['Indented', 'Motion', 'Print'], options)
  end

end


describe 'opt in motion_print support' do
  describe SimpleMotionPrint do
    it 'should support motion_print, arity == 0' do
      MotionPrint.logger(SimpleMotionPrint.new).should == "\e[0;33m\"SimpleMotionPrint\"\e[0m"
    end
    it 'should support motion_print, arity == 0, with options' do
      MotionPrint.logger(SimpleMotionPrint.new, force_color: :blue).should == "\e[1;34m\"SimpleMotionPrint\"\e[0m"
    end
  end
  describe CustomMotionPrint do
    it 'should support motion_print, arity == 1' do
      MotionPrint.logger(CustomMotionPrint.new).should == "\e[0;36m\"CustomMotionPrint\"\e[0m"
    end
  end
  describe IndentedMotionPrint do
    it 'should support motion_print, arity == 2' do
      MotionPrint.logger(IndentedMotionPrint.new).should == "[\n  \e[0;33m\"Indented\"\e[0m,\n  \e[0;33m\"Motion\"\e[0m,\n  \e[0;33m\"Print\"\e[0m\n]"
    end
  end
end
