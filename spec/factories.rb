require 'factory_girl'
Factory.define :picture do |f|
  f.sequence(:name) { |n| "Picture #{n}"}
end

Factory.define :user do |f|
  f.sequence(:email) { |n| "#{n}@example.com" }
end
