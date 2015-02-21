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
      create_task_from single_task_string
    end
  end

  def create
    build
    project.save
  end

  private
    def create_task_from(single_task_string)
      Task.new parse_title_and_size_from(single_task_string)
    end

    def parse_title_and_size_from(string)
      title, size = string.split(/:/)
      { title: title, size: produce_right(size) }
    end

    def produce_right(size)
      (size.blank? || size.to_i.zero?) ? DEFAULT_SIZE : size
    end
end
