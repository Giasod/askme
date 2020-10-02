# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :tag_questions, dependent: :destroy
  has_many :tags, through: :tag_questions

  validates :text, length: { maximum: 255 },
                   presence: true

  after_save_commit :update_tags

  private

  def update_tags
    self.tags =
      "#{text} #{answer}".downcase.scan(Tag::TAG_REGEX).uniq.map do |tag|
        Tag.find_or_create_by(name: tag.delete('#'))
      end
  end
end
