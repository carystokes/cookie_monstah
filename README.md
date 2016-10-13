# Cookie Monstah
Your app description, here.
![Build Status](https://codeship.com/projects/c2fbc380-6ba7-0134-0bb3-2e8398cca30e/status?branch=master)
![Code Climate](https://codeclimate.com/repos/57f27cfdf66260006100219c/badges/7a2d5f6f7ab6ca5a77a6/gpa.svg)
![Coverage Status](https://coveralls.io/repos/carystokes/cookie_monstah/badge.png)

The Cookie Monster Review Site  provides users a place to post and review cookie recipes. A list of all stored recipes is shown on the site home page. Clicking any recipe title will take you to a page with the details of that recipe, the creator of the recipe and any related reviews. You can also enter a new review for the recipe at the bottom of the page. This detail page also Clicking on “Add a Recipe” on the home page will take you to a page where you can input a new recipe. Users can see the list of recipes and the details of individual recipes, including reviews, without an account. Users must have an account and be logged in to review recipes. Once signed up, users can view and edit their profile information.

Authors:
Larisa Bainton
Shana Hausman
Mike Hawley
Cary Stokes

Link to deployed site:
http://cookie-monstah-recipes.herokuapp.com

Features:
User roles authentication (Devise)
Create, read, update and delete recipes and reviews (Rails, Ruby)
Emails recipe owner when new review created (SendGrid)
Avatar upload with cloud storage (CarrierWave, Fog and AWS)
Upvote or downvote individual recipes 
Recipe search (pg_search)
Unit and acceptance testing (Rspec and Capybara)
