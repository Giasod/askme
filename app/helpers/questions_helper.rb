module QuestionsHelper
  def question_author(question)
    if question.author.present?
      link_to "#{question.author.name} (@#{question.author.username})", user_path(question.author)
    else
      content_tag(:span, content_tag(:i, "Анонимный пользователь"))
    end
  end
end
