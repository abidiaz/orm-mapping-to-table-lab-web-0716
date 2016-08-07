require 'pry'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id

  def self.create_table
    sql = <<-SQL
    CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
    SQL
    DB[:conn].execute(sql)
  end

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?,?);"
    DB[:conn].execute(sql, name, grade)

    sql = "SELECT last_insert_rowid()"
    id_results = DB[:conn].execute(sql)
    
    @id = id_results[0][0]
  end

  def self.create(arguments)
    student1 = Student.new(arguments[:name], arguments[:grade])
    student1.save

    student1
  end
  
end
