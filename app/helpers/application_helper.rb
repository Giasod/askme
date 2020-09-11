module ApplicationHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_pack_path('media/images/avatar.jpg')
    end
  end

  def count_q_and_a
    total = @questions.size
    answered = @questions.select { |question| question.answer.present? }.size
    unanswered = total - answered
    { total: total, answered: answered, unanswered: unanswered }
  end
  
  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
