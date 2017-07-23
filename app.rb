require "bundler/setup"
Bundler.require
require_relative "Todo"

list_a = Todo.new("todo.md")

get "/" do
  erb :"index.html"
end

get "/todo_list" do 
  data = File.open("todo.md").read.split("\n")
  items = data.map.with_index do |item, index|
    {
      item_name: item[6..-1],
      item_status: item[3] == "x" ? "done" : "undone",
      item_index: index
    }
  end 
  erb :"todo_list.html", locals: {items: items}
end


post "/add_item" do 
  new_item = {item_name: params["name"], item_status: params["done"]}
  File.open("todo.md", "a") do |f|
    if new_item[:item_status] == "1"
      f << "- [x] " + new_item[:item_name] + "\n"
    else 
      f << "- [ ] " + new_item[:item_name] + "\n"
    end
  end
  redirect to ("/todo_list")
end


post "/update_all" do
  items = params["items"]

  if params["toggle"]
    index = params["toggle"].to_i
    if items[index][:item_status] == "done"
      items[index][:item_status] = "undone"
    else 
      items[index][:item_status] = "done"
    end
  end
  
  File.open("todo.md", "w") do |f|
    items.each do |e|
      if e[:item_status] == "done"
        f << "- [x] " + e[:item_name] + "\n"
      else 
        f << "- [ ] " + e[:item_name] + "\n"
      end
    end
  end
  redirect to ("/todo_list")
end


# get "/todo_list_save" do 
#   erb :"todo_list_save"
# end

get "/time_table" do 
  erb :"time_table.html"
end 

post "/time_table_print" do 
  erb :"time_table_print.html"
end 

get "/diary" do
  diary_text = File.open("diary.md").read 
  erb :"diary.html", locals: {diary_text: diary_text}
end

post "/diary_write" do
  File.open("diary.md", "a") do |f| 
    f << "\n\n" + params["orig"]
  end
  redirect to ("/diary_print")
end

get "/diary_print" do 
  diary_text = File.open("diary.md").read.split("\n\n").join("\n\n")
  erb :"diary_print.html", locals: {diary_text: diary_text}
end 
