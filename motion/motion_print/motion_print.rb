module MotionPrint

  class << self
    def console?
      !!defined?(MotionRepl)
    end

    def logger(object, indent_level = 1)
      case object
      when Symbol
        l_symbol object
      when Array
        l_array object, indent_level
      when Dir
        l_dir object
      when Hash
        l_hash object, indent_level
      # when File
      #   l_file object
      # when Struct
      #   l_struct object
      else
        colorize(object)
      end
    end

    def l_array(a, indent_level = 1)
      return "[]" if a.empty?
      out = []

      a.each do |arr|

        if arr.is_a?(Array) || arr.is_a?(Hash)
          v = logger(arr, indent_level + 1)
        else
          v = logger(arr)
        end
        out << (indent_by(indent_level) << v)
      end

      "[\n" << out.join(",\n") << "\n#{indent_by(indent_level-1)}]"
    end

    def l_hash(h, indent_level = 1)
      return "{}" if h.empty?
      data, out = [], []

      keys = h.keys.sort { |a, b| a.to_s <=> b.to_s }
      keys.each do |key|
        data << [logger(key), h[key]]
      end

      width = data.map { |key, | key.size }.max || 0
      width += indent_by(indent_level).length

      data.each do |key, value|
        if value.is_a?(Array) || value.is_a?(Hash)
          v = logger(value, indent_level + 1)
        else
          v = logger(value)
        end
        out << (align(key, width, indent_level) << colorize(" => ", :hash) << v)
      end

      "{\n" << out.join(",\n") << "\n#{indent_by(indent_level-1)}}"
    end

    def l_dir(d)
      ls = `ls -alF #{d.path.shellescape}`
      colorize(ls.empty? ? d.inspect : "#{d.inspect}\n#{ls.chop}")
    end

    def l_symbol(object)
      colorize(':' << object.to_s, object)
    end

    def colorize(object, type = nil)
      type = object if type.nil?
      Colorizer.send(decide_color(type), object)
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
