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
      [Task.new(title: task_string.split(/:/).first, size: 1)]
    end
  end
end
