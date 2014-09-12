require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  test 'user attributes must not be empty' do
    user = User.new
    assert user.invalid?
    assert user.errors[:name].any?
    assert user.errors[:email].any?
    assert user.errors[:phone].any?
  end

  test 'user should have unique name' do
    user1 = User.create(name: 'bill_preston',
                        email: 'bill_preston@wyldstallion.com', 
                        phone: '(098) 765-4321')
    assert user1.valid?, "user1 was not valid #{user1.errors.inspect}"
    
    user2 = User.new(name: 'bill_preston',
                     email: 'bill_preston@wyldstallion.com', 
                     phone: '(098) 765-4321')
    user2.valid?
    assert_not_nil user2.errors[:name].any?
  end

  test 'user should have unique email' do
    user1 = User.create(name: 'bill_preston',
                        email: 'bill_preston@wyldstallion.com', 
                        phone: '(098) 765-4321')
    assert user1.valid?, "user1 was not valid #{user1.errors.inspect}"
    
    user2 = User.new(name: 'bill_preston',
                     email: 'bill_preston@wyldstallion.com', 
                     phone: '(098) 765-4321')
    user2.valid?
    assert_not_nil user2.errors[:email].any?
  end

  test 'phone should be a string of 10 digits' do
    user = User.create(name: 'bill_preston',
                        email: 'bill_preston@wyldstallion.com', 
                        phone: '(098) 765-4321')
    assert_match(/\d{10}/, user.phone)
  end

end