FactoryGirl.define do
  factory :recipe do
    ingredients "garlic, carrots, soup"
    instructions "1. combine the ingredients 2. eat soup"
    title "Simple Recipe"
    description "Recipe for cookie soup"
    user_id 1
  end
end
