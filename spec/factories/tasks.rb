FactoryGirl.define do
  factory :task do
    content {Faker::Lorem.paragraph}
    priority 1
    project
  end

end
