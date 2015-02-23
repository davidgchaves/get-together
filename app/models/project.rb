class Project < ActiveRecord::Base
  has_many :tasks

  def total_size
    tasks.sum :size
  end
end
