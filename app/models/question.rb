# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  validates :text, length: { maximum: 255 },
                   presence: true
end
