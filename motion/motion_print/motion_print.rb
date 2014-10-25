module MotionPrint

  class << self
    def console?
      !!defined?(MotionRepl)
    end

    def cdq_object
      return CDQManagedObject if defined? CDQManagedObject
    end

    def logger(object, options = {})
      options = {
        indent_level: 1,
        force_color: nil
      }.merge(options)

      if object.respond_to?(:motion_print)
        arity = object.method(:motion_print).arity
        if arity == 1
          return object.motion_print(self)
        elsif arity == 2
          return object.motion_print(self, options)
        else
          return colorize(object.motion_print)
        end
      end

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
      when cdq_object
        l_cdq(object, options)
      else
        colorize(object, options[:force_color])
      end
    end

    def l_cdq(c, options)
      # Requires CDQ > v0.1.10
      if c.respond_to? :attributes
        "OID: " + colorize(c.oid.gsub('"',''), options[:force_color]) + "\n" + l_hash(c.attributes, options)
      else
        # old colorless method, still more informative than nothing
        c.log
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

    def colorize(object, force_color = nil)
      Colorizer.send(force_color || decide_color(object), object.inspect)
    end

    def hash_rocket(force_color = nil)
      Colorizer.send(force_color || decide_color(:hash), " => ")
    end

    def decide_color(object)
      colors[object.class.to_s.downcase.to_sym] || :white
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
        dir:        :white
      }
    end

    def indent_by(n)
      '  ' * n
    end

    def align(value, width, indent = 1)
      (indent_by(indent) + value.ljust(width)).chomp
    end
  end
end
