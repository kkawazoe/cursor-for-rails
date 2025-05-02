require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }
      it { is_expected.to allow_value('user@example.com').for(:email) }
      it { is_expected.not_to allow_value('invalid_email').for(:email) }
    end

    context 'password' do
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(8) }
      it { is_expected.to validate_presence_of(:password_confirmation) }
      it { is_expected.to validate_confirmation_of(:password) }

      context 'when updating an existing user' do
        let(:user) { create(:user) }

        it 'skips password validation if password is not provided' do
          expect(user.update(email: 'new@example.com')).to be true
        end

        it 'validates password if password is provided' do
          expect(user.update(password: 'short')).to be false
          expect(user.errors[:password]).to include('は8文字以上で入力してください')
        end
      end
    end
  end

  describe 'authentication' do
    let(:user) { create(:user) }

    context 'with valid password' do
      it 'authenticates successfully' do
        expect(user.authenticate('password123')).to eq user
      end
    end

    context 'with invalid password' do
      it 'fails to authenticate' do
        expect(user.authenticate('wrong_password')).to be false
      end
    end
  end
end
