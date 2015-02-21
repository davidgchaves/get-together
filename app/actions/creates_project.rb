class CreatesProject
  attr_accessor :project
  attr_reader :name, :task_string

  def initialize(name: "", task_string: "")
    @name = name
    @task_string = task_string
  end

  def build
    self.project = Project.new name: name
    project.tasks = convert_string_to_tasks
    project
  end

  def convert_string_to_tasks
    if task_string.blank?
      []
    else
      title, size = task_string.split(/:/)
      if size.nil? then size = 1 end
      [Task.new(title: title, size: size)]
    end
  end
end
