require 'rails_helper'

RSpec.describe BreedSearch, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:query_term)
    end
  end
end
