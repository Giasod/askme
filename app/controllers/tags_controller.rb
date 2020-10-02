class TagsController < ApplicationController
  before_action :load_tags

  def show
    @questions = @tag.questions
  end

  private

  def load_tags
    @tag = Tag.find_by!(name: params[:name])
  end
end
