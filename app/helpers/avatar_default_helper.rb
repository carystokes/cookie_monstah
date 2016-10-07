module AvatarDefaultHelper
  def user_avatar user
    if user.avatar.present?
      image_tag user.avatar :thumbnail
    else
      image_tag 'user_default.gif'
    end
  end

  def recipe_avatar recipe
    if recipe.avatar.present?
      image_tag recipe.avatar :thumbnail
    else
      image_tag 'cookie_default.jpg'
    end
  end
end
