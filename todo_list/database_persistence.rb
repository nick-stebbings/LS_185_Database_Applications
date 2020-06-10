require 'pg'

class DatabasePersistence
  def initialize
    @db = PG.connect(dbname: "todos")
  end

  def all_lists
    sql = "SELECT * FROM lists"
    result = @db.exec(sql)
    result.map do |tuple|
      { id: tuple["id"], name: tuple["name"], todos: [] }
    end
  end

  def find_list(id)
    sql = "SELECT * FROM lists WHERE id = $1"
    result = @db.exec_params(sql, [id])
    tuple = result.first
    { id: tuple["id"], name: tuple["name"], todos: [] }
  end

  def create_new_list(list_name)
    # all_lists << { id: get_next_id(:lists), name: list_name, todos: []}
  end

  def delete_list(id)
    # all_lists.reject!{ |list| list[:id] == id }
  end
  
  def update_list_name(id, list_name)
    # list = find_list(id)
    # list[:name] = list_name
  end
  
  def create_new_todo(list_id, todo_name)
    # list = find_list(list_id)
    # list[:todos] << { id: get_next_id(list), name: todo_name, completed: false }
  end
  
  def delete_todo_from_list(list_id, todo_id)
    # list = find_list(list_id)
    # list[:todos].delete_if{ |task| task[:id] == todo_id.to_i }
  end
  
  def update_todo_status(list_id, todo_id, new_status)
    # list = find_list(list_id)
    # todo = list[:todos].find { |task| task[:id] == todo_id.to_i }
    # todo[:completed] = new_status?
  end
  
  def mark_all_todos_as_completed(list_id)
    # list = find_list(list_id)
    # list[:todos].each do |task|
    #   task[:completed] = true
    # end
  end

end
