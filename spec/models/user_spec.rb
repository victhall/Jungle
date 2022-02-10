require 'rails_helper'

RSpec.describe User, type: :model do

  test_user = User.new(
    name: 'victoria',
    email: 'v1hall@gmail.com',
    password: 'password',
    password_confirmation: 'password'
  )

  describe "Validations" do

    it 'test_user is valid' do
      expect(test_user).to be_valid
    end

    it 'invalid first name' do
      test_user.name = nil
      expect(test_user).to be_invalid
      expect(test_user.errors.full_messages).to include("Name can't be blank")
    end
 
    it 'invalid email' do
      test_user.email = nil
      expect(test_user).to be_invalid
      expect(test_user.errors.full_messages).to include("Email can't be blank")
    end

    it "invalid password" do
      test_user.password = nil
      expect(test_user).to be_invalid
      expect(test_user.errors.full_messages).to include("Password can't be blank")
    end
 
    it "invalid password confirmation" do
      test_user.password_confirmation = nil
      expect(test_user).to be_invalid
      expect(test_user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "invalid confirmed passwords" do
      test_user.password_confirmation = "secret"
      expect(test_user).to be_invalid
      expect(test_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "invalid password, too short" do
      test_user.password = "mm"
      expect(test_user).to be_invalid
      expect(test_user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it "invalid, email is already taken (not case sensitive)" do
      test_user2 = User.new(
        name: 'john',
        email: 'V1HALl@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      test_user2.save
      test_user.save
      expect(test_user).to be_invalid, "Email has already been taken"
      end
      
    it "invalid, email is already taken" do
      test_user2 = User.new(
        name: 'john',
        email: 'v1hall@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      test_user2.save
      test_user.save
      expect(test_user).to be_invalid, "Email has already been taken"
      end
  end  

  describe '.authenticate_with_credentials' do
  
    it "should be valid for valid user" do
      user = User.new(
        name: 'victoria',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      expect(User.authenticate_with_credentials('test@test.com', 'password')).not_to be(nil)
    end

    it "should be not valid for invalid credentials" do
      user = User.new(
        name: 'victoria',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      expect(User.authenticate_with_credentials('test@test.com', 'pasword')).to be(nil)
    end

    it "should pass even when spaces in email" do
      user = User.new(
        name: 'victoria',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      expect(User.authenticate_with_credentials('test@test.com', 'pasword')).to be(nil)
    end

    it "should pass when correct email is in caps" do
      user = User.new(
        name: 'victoria',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      expect(User.authenticate_with_credentials('TEST@test.COM', 'pasword')).to be(nil)
    end
  end
end