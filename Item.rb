  require "bundler/setup"
  Bundler.require

  class Item
    attr_accessor :name, :done
    attr_reader :item, :test
    def initialize(name, done = false)
      @test = name
      @name = name[6..-1]
      @done = name[3]
    end
    
    def done?
      @done == "x"
    end

    def undone?
      @done == " "
    end
    
    def mark_done!
      @done = "x"
      "- #{@done} #{@name}"
    end

    def mark_undone!
      @done[1] = " "
      "- #{@done} #{@name}"
    end
    
    
    def display
      if done?
        "- #{@done} #{@name}".colorize(:green)
      else
        "- #{@done} #{@name}".colorize(:yellow)
      end
    end

    def find_keyword(keyword)
      @name.include?(keyword) #return true or false
    end
    
    
    def self.new_from_line(line) #Ham nay se tra ve 1 cai dia chi
      name = line[6..-1]
      done = line[3] == "x" 
      Item.new(name, done)
    end
  end

 



