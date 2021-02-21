require 'rails_helper'

RSpec.describe BreedSearchResult, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:breed_id)
    end
  end
end
