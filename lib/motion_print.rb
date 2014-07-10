unless defined?(Motion::Project::App)
  raise "This must be required from within a RubyMotion Rakefile"
end

Motion::Project::App.setup do |app|
  parent = File.join(File.dirname(__FILE__), '..')
  files = [File.join(parent, 'motion/motion_print/version.rb')]
  files << File.join(parent, 'motion/motion_print/core_ext/kernel.rb')
  files << File.join(parent, 'motion/motion_print/core_ext/string.rb')
  files << Dir.glob(File.join(parent, "motion/**/*.rb"))
  files.flatten!.uniq!
  app.files.unshift files
end
