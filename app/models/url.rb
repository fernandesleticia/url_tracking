# frozen_string_literal: true

class Url < ApplicationRecord
  before_validation :generate_short_url
  
  validates_presence_of :original_url
  validates :original_url, format: URI::regexp(%w[http https])

  # scope :latest, -> {}
  
  def generate_short_url
    return unless self.short_url.nil? || self.short_url.empty?
    self.short_url = "http://url_shorten/" + SecureRandom.uuid[0..5].to_s 
  end
end
