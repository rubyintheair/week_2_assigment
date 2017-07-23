
require_relative "Item"

require "bundler/setup"
Bundler.require

class List 
  attr_accessor :items
  def initialize(items = [])
    @items = items
  end

  def add(item)
    @items << Item.new(item)
  end

  def display_1
    # items.each_with_index {|item, index| " #{item.done} #{item.name} {index + 1}"}
    @items.each_with_index {|item, index| puts "#{item.done} #{item.name} (#{index + 1})"}
  end

  def display
    @items.each_with_index do |item, index| 
      if item.done?
        puts "#{item.done} #{item.name.colorize :green} (#{index + 1})"
      else
        puts "#{item.done} #{item.name.colorize :yellow} (#{index + 1})"
      end
    end
  end

  def done_items
    @items.select {|item| item.done?}
  end

  def undone_items
    @items.select {|item| !item.done? }
  end
  
  
  def display_done
    done_items.each_with_index {|item, index| puts "#{item.done} #{item.name} (#{index + 1})"}
  end
  
  def display_undone
    undone_items.each_with_index {|item, index| puts "#{item.done} #{item.name} (#{index + 1})".colorize :red}
  end
  
  def delete(index)
    @items.delete_at(index)
  end
  
  def check(index)
    @items[index].mark_done!
  end
  
  def uncheck(index)
    @items[index].mark_undone!
  end

  def keyword_items(keyword)
    @items.select {|item| item.find_keyword(keyword)}
  end

  def display_keyword(keyword)
    if keyword_items(keyword).count == 0
      puts "Sorry!!! We don't find any item contains the \"#{keyword}\"".upcase.colorize(:color => :red)
    else
      keyword_items(keyword).each_with_index {|item, index| puts "#{item.done} #{item.name} (#{index + 1})".colorize( :background => :green)}
    end
  end

  def insert_item(index, item)
    @items.insert(index, item)
  end
  
  def display_as_table
    @table_content = @items.map.with_index do |item, index| 
      if item.done?
        [item.done, item.name, (index + 1).to_s].map {|e| e.colorize(:green)}
      else
        [item.done, item.name, (index + 1).to_s].map {|e| e.colorize(:yellow)}
      end   
    end
    table = Terminal::Table.new :headings => ["Status".colorize(:yellow), "Item".colorize(:yellow), "Number".colorize(:yellow)], :rows => @table_content
    # table.align_column(2, :center)
  end
  
  
end




