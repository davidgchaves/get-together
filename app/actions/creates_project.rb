class CreatesProject
  attr_accessor :project
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def build
    self.project = Project.new @name
  end
end
