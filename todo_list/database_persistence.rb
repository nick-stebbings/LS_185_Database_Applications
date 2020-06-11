require 'pg'
class DatabasePersistence
  def initialize(logger)
    @db = PG.connect(dbname: "todos")
    @logger = logger
  end

  def query(statement, *params)
    @logger.info "#{statement} : #{params}"
    @db.exec_params(statement, params)
  end

  def all_lists
    sql = <<~SQL
      SELECT l.*,
      COUNT(l.id) AS todos_count,
      COUNT(NULLIF(t.completed, true)) AS  todos_remaining_count
      FROM lists l
      LEFT JOIN todos t ON (t.list_id = l.id)
      GROUP BY l.id
      ORDER BY l.name;
    SQL
    result = query(sql)
    result.map do |tuple|
      tuple_to_list_hash(tuple)
    end
  end

  def find_list(id)
    sql = <<~SQL
      SELECT l.*,
      COUNT(l.id) AS todos_count,
      COUNT(NULLIF(t.completed, true)) AS  todos_remaining_count
      FROM lists l
      WHERE l.id = $1
      LEFT JOIN todos t ON (t.list_id = l.id)
      GROUP BY l.id
      ORDER BY l.name;
    SQL

    sql = "SELECT * FROM lists WHERE id = $1"
    result = query(sql, id)
    tuple_to_list_hash(result.first)
  end

  def create_new_list(list_name)
    sql = "INSERT INTO lists (name) VALUES ($1)"
    query(sql, list_name)
  end
  
  def delete_list(id)
    sql1 = "DELETE FROM todos WHERE list_id = $1"
    sql2 = "DELETE FROM lists WHERE id = $1"
    query(sql1, id)
    query(sql2, id)
  end
  
  def update_list_name(id, list_name)
    sql = "UPDATE lists SET name = $2 WHERE id = $1"
    query(sql, id, list_name)
  end
  
  def create_new_todo(list_id, todo_name)
    sql = "INSERT INTO todos (name, list_id) VALUES ($2, $1)"
    query(sql, list_id, todo_name)
  end
  
  def delete_todo_from_list(list_id, todo_id)
    sql = "DELETE FROM todos WHERE list_id = $1 AND id = $2"
    result = query(sql, list_id, todo_id)
  end
  
  def update_todo_status(list_id, todo_id, new_status)
    sql = "UPDATE todos SET completed = $3 WHERE id = $2 AND list_id = $1"
    query(sql, list_id, todo_id, new_status)
  end
  
  def mark_all_todos_as_completed(list_id)
    sql = "UPDATE todos SET completed = true WHERE list_id = $1"
    query(sql, list_id)
  end

  def all_todos_from(list_id)
    sql = "SELECT * FROM todos WHERE list_id = $1"
    result = query(sql, list_id)
    result.map do |tuple|
      { id: tuple["id"].to_i, name: tuple["name"], completed: (tuple["completed"] == 't'), list_id: tuple["list_id"] }
    end
  end

  private

  def tuple_to_list_hash(tuple)
   {                     id: tuple["id"].to_i,
                       name: tuple["name"],
                todos_count: tuple["todos_count"].to_i,
      todos_remaining_count: tuple["todos_remaining_count"].to_i
    }
  end
end
