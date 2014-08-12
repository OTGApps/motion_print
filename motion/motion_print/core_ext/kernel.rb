module Kernel
  def mp(object, options = {})
    puts ""
    puts caller[0]
    puts MotionPrint.logger(object)
    puts ""
    object unless MotionPrint.console?
  end

  module_function :mp
end
