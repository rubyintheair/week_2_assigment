require_relative "List"

require "bundler/setup"
Bundler.require

class Todo
  def initialize(file_name)
    data = File.read(file_name).split("\n")
    @items = data.map {|item| Item.new(item.chomp)}
    @list = List.new(@items)
  end

  def list
    @list
  end
  
  def show_all
    @list.display
  end

  def show_done
    @list.display_done
  end

  def show_undone
    @list.display_undone
  end

  def show_keyword(keyword)
    @list.display_keyword(keyword)
  end
  

  def add(item) 
    @list.add(item) 
  end

  def delete_item(index)
    @list.delete(index)
    @list
  end

  def check_item(index)
    @list.check(index)
  end
  
  def uncheck_item(index)
    @list.uncheck(index)
  end

  def instruction
    puts ("="*20 + "  Guideline  " + "="*20).colorize(:color => :green)
    puts ("="*10 + " + task_content: add new task "  + "="*10).colorize(:color => :green)
    puts ("="*10 + " remove index: remove task at index order and save to Trash file "  + "="*10).colorize(:color => :green)
    puts ("="*10 + " all  | done | undone: display all/done/undone tasks "  + "="*10).colorize(:color => :green)
    puts ("="*10 + " check index | uncheck index: check/uncheck index task "  + "="*10).colorize(:color => :green)
    puts ("="*10 + " save -f file_name: Save and print current file to another file "  + "="*10).colorize(:color => :green)
    puts ("="*10 + " find keyword: find all tasks which contain keyword "  + "="*10).colorize(:color => :green)
  end

  def show_table
    puts @list.display_as_table
  end
  

  def get_input_and_exit(input)
    if input == "exit"
      "exit"
    elsif input.include?("+")
      # puts "What do you want to add? "
      # new_item = gets.chomp
      add("- [ ] #{input[2..-1]}")
      puts "Display all items: "
      # show_all
      show_table
    elsif input.include?("remove")
      index = input.split(" ")[1].to_i
      trash = File.new("Trash.txt",  "a")
      @trash_item = @list.items[index - 1]
      trash << "- #{@trash_item.done} #{@trash_item.name}\n"
      trash.close
      delete_item(index - 1)
      puts "Display all items: "
      show_all
    elsif input.include?("uncheck")
      index = input.split(" ")[1].to_i
      uncheck_item(index - 1)
      puts "Display all items: "
      # show_all
      show_table
    elsif input.include?("check")
      p input
      index = input.split(" ")[1].to_i
      check_item(index - 1)
      puts "Display all items: "
      # show_all
      show_table
    elsif input == "done"
      puts "Display done items: "
      show_done
    elsif input == "undone"
      puts "Display undone items: "
      show_undone
    elsif input == "all"
      puts "Display all items: "
      # show_all
      show_table
    elsif input.include?("find")
      puts "Display item with keyword #{input[5..-1]}"
      show_keyword(input[5..-1])
    elsif input.include?("save -f")
      f = File.new("#{input[8..-1]}.txt",  "a")
      @list.items.each {|e| f << "- #{e.done} #{e.name}\n"}
      f.close
    else
      puts "Sorry! I don't understand what you mean? Let try again!!!"
    end
  end
  
  
  def prompt
    puts "What do you want to do?".upcase.colorize(:color => :yellow)
    puts instruction
    @input = gets.chomp
    loop do 
      if @input == "exit"
        puts "Good bye!!!\nSee you later".upcase.colorize(:color => :red)
        break
      else
        get_input_and_exit(@input)
      end
      puts "What do you want to do NEXT? ".colorize(:color => :yellow) 
      puts instruction
      @input = gets.chomp
    end
  end
  

end





