module Kernel
  def mp(object, options = {})
    puts MotionPrint.logger(object)
    object unless MotionPrint.console?
  end

  module_function :mp
  alias :mp :ap
end
