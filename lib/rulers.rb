require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      # `echo debug > debug.txt`;
      if env["PATH_INFO"] == "/favicon.ico"
        return [404, {"Content-Type" => "text/html"}, []]
      end
      
      # if env["PATH_INFO"] == "/"
      #   return [200, {"Content-Type" => "text/html"}, [File.read("public/index.html")]] #Not sure why this isn't able to find this file.
      # end
      
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
      rescue RuntimeError
        text = "<h1><em>Sorry, we don't know what to do with that</em></h1>"
      end
      [200, {"Content-Type" => "text/html"}, [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
