class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(id=0, name, grade)
    @name = name 
    @grade = grade
    @id = id
  end 
  
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
        SQL
    DB[:conn].execute(sql) 
  end 
  
  def self.drop_table
    sql =  <<-SQL 
      DROP TABLE IF EXISTS students
        SQL
    DB[:conn].execute(sql) 
  end 
  
  def save
    @id += 1
    sql = <<-SQL
      INSERT INTO students (id, name, grade) 
      VALUES (?, ?, ?)
    SQL
 
    DB[:conn].execute(sql, self.id, self.name, self.grade)
  end
  
  def self.create(hash)
    sql = <<-SQL
      INSERT INTO students (id, name, grade) 
      VALUES (?, ?, ?)
    SQL
 
    DB[:conn].execute(sql, hash[:id], hash[:name], hash[:grade]) 
  
  student = Student.new(hash[:id], hash[:name], hash[:grade])
  end
  
end
