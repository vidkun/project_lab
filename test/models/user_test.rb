require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test "must have name" do
    user = User.new()
    assert user.invalid?
    assert_equal ["can't be blank"], user.errors[:name]
  end  

  test "phone must be vaild" do
    user = User.new(name: users(:one).name,
                    email: users(:one).email,
                    encrypted_password: users(:one).encrypted_password,
                    phone: 123)
    assert user.invalid?
    assert_equal ["is the wrong length (should be 10 characters)"], user.errors[:phone]
  end
end
