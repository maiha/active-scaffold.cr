#!/usr/bin/env crystal

require "colorize"

class Generator
  getter controller_class_name : String
  getter table_name : String

  def initialize(name : String, @adapter : String? = nil)
    name = name.sub(/Controller$/, "")
    fatal "Specify a controller name" if name.empty?

    case name
    when /^[A-Z][a-zA-Z0-9]*$/
      @controller_class_name = name
      @table_name = underscore(name)
    when /^[a-z][_a-z0-9]*$/
      @controller_class_name = classify(name)
      @table_name = name
    else
      fatal "Invalid controller name"
    end    
  end

  private def model_class_name
    @controller_class_name.sub(/s$/, "")
  end

  private def model_path
    "src/models/%s.cr" % @table_name.sub(/s$/, "")
  end

  private def routes_path
    "config/routes.cr"
  end

  def generate!
    generate_route!
    generate_model!
    generate_controller!
    generate_view!
  end
  
  def generate_model!
    path = model_path
    return warn("SKIP: #{path}") if File.exists?(path)

    buffer = <<-EOF
      class #{model_class_name} < Granite::ORM::Base
        adapter mysql
        table_name #{table_name}
      end
      EOF
    File.write(path, buffer)
    info("NEW: #{path}")
  end

  def generate_controller!
    path = "src/controllers/%s_controller.cr" % table_name
    return warn("SKIP: #{path}") if File.exists?(path)

    buffer = <<-EOF
      class #{controller_class_name}Controller < ApplicationController
        include ActiveScaffold(#{model_class_name})

        active_scaffold do |config|
        end
      end
      EOF
    File.write(path, buffer)
    info("NEW: #{path}")
  end

  def generate_view!
    src = "../../lib/active_scaffold/src/active_scaffold/views"
    dst = table_name
    Dir.cd("src/views") {
      return warn("SKIP: src/views/#{dst}") if File.exists?(dst)
      File.symlink(src, dst)
      info("NEW: src/views/#{dst}")
    }
  end

  def generate_route!
    path   = "config/routes.cr"
    route  = %Q(resources "/%s", %sController) % [table_name, controller_class_name]
    buffer = File.read(path)
    return warn("SKIP: #{path}") if buffer.includes?(route)
    
    buffer = buffer.sub(/^(\s+routes :web do)\s*$/m){
      %Q(%s\n    %s) % [$1, route]
    }
    File.write(path, buffer)
    info("UPDATE: #{path}")
  end

  private def fatal(msg : String)
    msg = msg.colorize.red
    abort <<-EOF
      #{msg}
      usage: #{PROGRAM_NAME} CONTROLLER_NAME
      example) #{PROGRAM_NAME} Users
      EOF
  end

  private def info(msg : String)
    STDOUT.puts msg.colorize.green
  end

  private def warn(msg : String)
    STDERR.puts msg.colorize.yellow
  end

  private def underscore(v : String) : String
    v.gsub(/([A-Z])/){ "_" + $1.downcase}.sub(/^_/, "")
  end

  private def classify(v : String) : String
    v.gsub(/(^|_)(.)/){ $2.upcase }
  end
end

generator = Generator.new(ARGV.shift?.to_s)
generator.generate!
