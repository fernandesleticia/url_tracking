# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  subject { described_class.new(original_url: 'https://valid-url') }
  
  describe 'validations' do
    it 'should validates original URL is a valid URL' do
      subject.original_url = 'invalid-url'
      expect(subject).to_not be_valid
    end

    it 'should validates original URL is present' do
      subject.original_url = nil
      expect(subject).to_not be_valid
    end

    context 'when short url could not be generated' do 
      before { allow_any_instance_of(Url).to receive(:generate_short_url).and_return(nil) }

      it 'should validates short URL is present' do
        expect(subject).to_not be_valid
      end
    end
  end

  describe 'generate_short_url' do 
    it 'should generate a short url on creation' do 
      expect(subject).to be_valid
    end
  end
end
