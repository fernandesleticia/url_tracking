# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url

  validates_presence_of :browser, :platform
end
