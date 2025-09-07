class DatabaseHelper
  def create_user_table
    sql = <<~SQL
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name VARCHAR(255),
        email VARCHAR(255) UNIQUE
      );
    SQL
    execute(sql)
  end

  def create_posts_table
    sql = <<~SQL
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY,
        title VARCHAR(255),
        content TEXT
      );
    SQL
    execute(sql)
  end

  def get_user_report
    query = <<-REPORT
    SELECT users.name, COUNT(posts.id) as post_count
    FROM users
    LEFT JOIN posts ON users.id = posts.user_id
    GROUP BY users.id
    REPORT
    execute(query)
  end

  def get_admin_report
    query = <<-REPORT
    SELECT users.name, COUNT(posts.id) as post_count
    FROM users
    LEFT JOIN posts ON users.id = posts.user_id
    GROUP BY users.id
    REPORT
    execute(query)
  end

  private

  def execute(sql)
    # This method should be duplicated
    puts "Executing: #{sql}"
    database.query(sql)
  end

  def run_query(sql)
    # This method should be duplicated
    puts "Executing: #{sql}"
    database.query(sql)
  end
end