module MotionPrint
  module Colorizer
    extend self
    %w(gray red green yellow blue purple cyan white).each_with_index do |color, i|
      define_method color do |str|
        "\e[1;#{30+i}m#{str}\e[0m"
      end

      define_method "#{color}ish" do |str|
        "\e[0;#{30+i}m#{str}\e[0m"
      end
    end

    alias :black :grayish
    alias :pale  :whiteish
  end
end
