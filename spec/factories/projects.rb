FactoryGirl.define do
  factory :project do
    name "Project Runway"
    due_date 3.days.from_now
  end
end
