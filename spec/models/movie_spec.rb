require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do
    subject { build(:movie) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:restrict) }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5.0) }
    it { is_expected.to validate_presence_of(:director_name) }
    it { is_expected.to validate_numericality_of(:to_favorite_registered_count).only_integer.is_greater_than_or_equal_to(0) }

    context 'restrict only allows defined enum values' do
      it 'allows valid enum values' do
        Movie.restricts.keys.each do |key|
          expect { build(:movie, restrict: key) }.not_to raise_error
        end
      end

      it 'raises error for invalid enum value' do
        expect { build(:movie, restrict: :invalid) }.to raise_error(ArgumentError)
      end
    end
  end
end
