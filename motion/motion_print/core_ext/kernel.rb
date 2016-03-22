module Kernel
  def mp(object, options = {})
    output_stream = RUBYMOTION_ENV == "test" ? $stderr : $stdout
    
    log = MotionPrint.logger(object, options)
    if MotionPrint.simulator?
      output_stream.puts log
    elsif MotionPrint.nslog_enabled?
      log.split("\n").each { |line| NSLog(line) }
    end

    object unless MotionPrint.console?
  end

  module_function :mp
end
