require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) {
      User.new(first_name: "Yonseung",
        last_name: "Kim",
        email: "test@test.com",
        password: "10101010",
        password_confirmation: "10101010")
    }

    it 'should have a valid test' do
      expect(user).to be_valid
    end

    it 'should be invalid without a first_name' do
      user.first_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should be invalid without a last_name' do
      user.last_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should be invalid without a password' do
      user.password = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    
    it 'should be invalid without a password_confirmation' do
      user.password_confirmation = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'password must be more than 8 length' do
      user.password = "1010"
      user.password_confirmation = "1010"
      expect(user).to_not be_valid 
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'email must be insensitive and unique' do
      User.create(first_name: "Yonseung",
        last_name: "Kim",
        email: "test@TEST.com",
        password: "10101010",
        password_confirmation: "10101010")
      expect(user).to_not be_valid 
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    let(:user) {
      User.create(first_name: "Yonseung",
        last_name: "Kim",
        email: "test@test.com",
        password: "10101010",
        password_confirmation: "10101010")
    }

    it 'should log in a user who enter valid credentials' do
      user.save
      expect(User.authenticate_with_credentials("test@test.com", "10101010")).to be_truthy
    end

    it 'should log in a user who enter wrong case for their email' do
      user.save
      expect(User.authenticate_with_credentials("test@TEST.com", "10101010")).to be_truthy
    end

    it 'should log in a user who enter in a few spaces before and/or after their email address' do
      user.save
      expect(User.authenticate_with_credentials(" test@test.com ", "10101010")).to be_truthy
    end
  end
  
end
