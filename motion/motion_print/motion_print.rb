module MotionPrint

  class << self
    def console?
      !!defined?(MotionRepl)
    end

    def logger(object, options = {})
      options = {
        indent_level: 1,
        force_color: nil,
        ivar: true
      }.merge(options)

      case object
      when nil
        colorize(object, options[:force_color])
      when Symbol
        l_symbol(object, options)
      when Array
        l_array(object, options)
      when Dir
        l_dir(object, options)
      when Hash
        l_hash(object, options)
      # when File
      #   l_file object
      # when Struct
      #   l_struct object
      else
        l_custom(object, options)
      end
    end

    def l_array(a, options)
      return "[]" if a.empty?
      out = []

      a.each do |arr|
        out << (indent_by(options[:indent_level]) << array_hash_logger(arr, options))
      end

      "[\n" << out.join(",\n") << "\n#{indent_by(options[:indent_level]-1)}]"
    end

    def l_hash(h, options)
      return "{}" if h.empty?
      data, out = [], []

      h.keys.each do |key|
        data << [logger(key, options), h[key]]
      end

      width = data.map { |key, | key.size }.max || 0
      width += indent_by(options[:indent_level]).length

      data.each do |key, value|
        out << (align(key, width, options[:indent_level]) << hash_rocket(options[:force_color]) << array_hash_logger(value, options))
      end

      "{\n" << out.join(",\n") << "\n#{indent_by(options[:indent_level]-1)}}"
    end

    def array_hash_logger(value, options)
      if value.is_a?(Array) || value.is_a?(Hash)
        logger(value, options.merge({indent_level: options[:indent_level] + 1}))
      else
        logger(value, options)
      end
    end

    def l_dir(d, options)
      ls = `ls -alF #{d.path.shellescape}`
      colorize(ls.empty? ? d.inspect : "#{d.inspect}\n#{ls.chop}", options[:force_color])
    end

    def l_symbol(object, options)
      colorize(object, options[:force_color])
    end

    def l_custom(object, options)
      if object.respond_to?(:motion_print)
        case object.method(:motion_print).arity
        when 1
          return object.motion_print(self)
        when 2
          return object.motion_print(self, options)
        else
          return colorize(object.motion_print, options[:force_color])
        end
      elsif object.respond_to?(:instance_variables) && !object.instance_variables.empty?
        return l_instance_variables(object, options)
      end

      colorize(object, options[:force_color])
    end

    # Output a list of instance variables.  only allows one level to avoid excessive output
    # and circular references. Will also show a different color for instance variables that
    # have accessors or not.
    def l_instance_variables(object, options)
      ivars = object.instance_variables.reject {|item| !item.to_s.start_with?('@')} # only allow proper instance variables
      return colorize(object, options[:force_color]) if !options[:ivar] || ivars.empty?
      data  = []
      out   = [class_address(object, options[:force_color])]

      ivars.each do |ivar|
        use_color = object.respond_to?(ivar.to_s[1..-1]) ? colors[:method] : colors[:ivar]
        data     << [logger(ivar, options.merge({force_color: specific_color(use_color, options)})), ivar]
      end

      width  = data.map { |ivar_str, | ivar_str.size }.max || 0
      width += indent_by(options[:indent_level]).length
      
      data.each do |ivar_str, ivar|
        out << (align(ivar_str, width, options[:indent_level]) << hash_rocket(options[:force_color]) <<
                logger(object.instance_variable_get(ivar), options.merge({ivar: false, force_color: specific_color(:pale, options)})))
      end

      out.join("\n") << "\n#{indent_by(options[:indent_level] - 1)}"
    end

    def colorize(object, force_color = nil)
      Colorizer.send(force_color || decide_color(object), object.inspect)
    end

    def hash_rocket(force_color = nil)
      Colorizer.send(force_color || decide_color(:hash), " => ")
    end

    def class_address(object, force_color = nil)
      Colorizer.send(force_color || colors[:class], "#<#{object.class}:0x%08x>" % (object.object_id))
    end

    def decide_color(object)
      colors[object.class.to_s.downcase.to_sym] || :white
    end
    
    def specific_color(color, options)
      options[:force_color] || color
    end

    def colors
      {
        args:       :pale,
        array:      :white,
        bigdecimal: :blue,
        class:      :yellow,
        date:       :greenish,
        falseclass: :red,
        fixnum:     :blue,
        float:      :blue,
        hash:       :pale,
        keyword:    :cyan,
        method:     :purpleish,
        nilclass:   :red,
        rational:   :blue,
        string:     :yellowish,
        struct:     :pale,
        symbol:     :cyanish,
        time:       :greenish,
        trueclass:  :green,
        variable:   :cyanish,
        dir:        :white,
        ivar:       :cyanish
      }
    end

    def indent_by(n)
      '  ' * n
    end

    def align(value, width, indent = 1)
      (indent_by(indent) + value.ljust(width)).chomp
    end
    
    def enable_nslog
      @nslog_enabled = true
    end

    def nslog_enabled?
      !@nslog_enabled.nil?
    end

    # Borrowed from BubbleWrap's Device.simulator?
    def simulator?
      if UIDevice.currentDevice.systemVersion.to_i >= 9
        !NSBundle.mainBundle.bundlePath.start_with?('/var/')
      else
        !(UIDevice.currentDevice.model =~ /simulator/i).nil?
      end
    end
  end
end
