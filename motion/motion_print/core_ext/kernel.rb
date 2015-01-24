module Kernel
  def mp(object, options = {})
    logger = MotionPrint.logger(object)

    if MotionPrint.simulator?
      puts logger
    elsif MotionPrint.nslog_enabled?
      logger.split("\n").each { |line| NSLog(line) }
    end
    object unless MotionPrint.console?
  end

  module_function :mp
end
