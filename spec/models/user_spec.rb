require 'rails_helper'

RSpec.describe User, type: :model do
  it "is not valid - empty attributes" do
    expect(User.new).to_not be_valid
  end
  it "is not valid - empty username" do
    user = build(:user, username: "")
    expect(user).to_not be_valid
  end
  it "is not valid - empty password" do
    user = build(:user, password: "")
    expect(user).to_not be_valid
  end
  it "is not valid - password mismatch" do
    user = build(:user, password_confirmation: "")
    expect(user).to_not be_valid
  end
  it "is valid" do
    user = build(:user)
    expect(user).to be_valid
  end 
end