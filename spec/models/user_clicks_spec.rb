require 'rails_helper'

RSpec.describe UserClick, type: :model do
  describe 'validations' do
    it 'validates presence of required fields' do
      should validate_presence_of(:path_name)
      should validate_presence_of(:clicks_amount)
    end
  end
end
