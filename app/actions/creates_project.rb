class CreatesProject
  DEFAULT_SIZE = 1

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
    task_string.split(/\n/).map do |single_task_string|
      Task.new(parse_title_and_size_from single_task_string)
    end
  end

  private
    def parse_title_and_size_from(string)
      title, size = string.split(/:/)
      { title: title, size: size || DEFAULT_SIZE }
    end
end
