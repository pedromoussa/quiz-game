require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  it "is not valid - is dependent on User" do
    expect(UserAnswer.new).to_not be_valid
  end
  it "is not valid - must have message" do
    user_answer = build(:user_answer, mensagem: "")
    expect(user_answer).to_not be_valid
  end
  it "is not valid - must have series_id" do
    user_answer = build(:user_answer, series_id: "")
    expect(user_answer).to_not be_valid
  end
  it "is not valid - must have character_id" do
    user_answer = build(:user_answer, character_id: "")
    expect(user_answer).to_not be_valid
  end
  it "is valid" do
    user_answer = build(:user_answer)    
    expect(user_answer).to be_valid
  end
end
