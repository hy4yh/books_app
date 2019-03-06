# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  belongs_to :user

  validates :title, presence: true
  validates :memo, presence: true
end
