# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler/gem_tasks'
require 'bundler/setup'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'motion_print'
  app.identifier = 'io.otgapps.motion_print'
  app.device_family = [:iphone, :ipad]
  app.prerendered_icon = true
  app.interface_orientations = [:portrait, :landscape_left, :landscape_right, :portrait_upside_down]
  app.frameworks += %w(QuartzCore CoreGraphics)
end
