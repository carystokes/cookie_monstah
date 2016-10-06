# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    sequence(:email) { |n| 'user#{n}@email.com' }
    password 'password'
  end

  factory :recipe do
    ingredients 'garlic, carrots, soup'
    instructions '1. combine the ingredients 2. eat soup'
    title 'Simple Recipe'
    description 'Recipe for cookie soup'
    user
  end

  factory :review do
    rating 3
    body 'soup is not a cookie but it was delicious'
    recipe
    user
  end
end
