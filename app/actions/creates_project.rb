class CreatesProject
  attr_accessor :project
  attr_reader :name

  def initialize(name: "", task_string: "")
    @name = name
  end

  def build
    self.project = Project.new name: name
  end

  def convert_string_to_tasks
    []
  end
end
