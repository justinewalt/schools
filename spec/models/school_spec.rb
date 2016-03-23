require 'rails_helper'

RSpec.describe School, type: :model do
	describe 'description' do
		it { should validate_presence_of :name } 
	end
end
