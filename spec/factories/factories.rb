# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Smith'
    email 'user@example.com'
    password 'password'
  end

  factory :recipe do
    ingredients "garlic, carrots, soup"
    instructions "1. combine the ingredients 2. eat soup"
    title "Simple Recipe"
    description "Recipe for cookie soup"

    user
  end
end
