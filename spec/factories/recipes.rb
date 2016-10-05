FactoryGirl.define do
  factory :recipe do
    ingredients "garlic, carrots, soup"
    instructions "1. combine the ingredients 2. eat soup"
    title "Simple Recipe"
    description "Recipe for cookie soup"
    user_id 1
  end
end

FactoryGirl.define do
  factory :review do
    rating 3
    body 'soup is not a cookie but it was delicious'
    recipe_id 1
    user_id 1
  end
end
