module Kernel
  def mp(object, options = {})
    output_stream = RUBYMOTION_ENV == "test" ? $stderr : $stdout
    output_stream.puts MotionPrint.logger(object)
    object unless MotionPrint.console?
  end

  module_function :mp
end
