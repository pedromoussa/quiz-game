require 'rails_helper'

RSpec.describe Character, type: :model do
  it "is not valid - is dependent on series" do
    expect(Character.new).to_not be_valid
  end
  it "is not valid - empty attributes" do
    character = build(:character, nome_real: "", nome_personagem: "")
    expect(character).to_not be_valid
  end
  it "is not valid - empty nome_personagem" do
    character = build(:character, nome_personagem: "")
    expect(character).to_not be_valid
  end
  it "is not valid - empty nome_real" do
    character = build(:character, nome_real: "")
    expect(character).to_not be_valid
  end
  it "is valid" do
    character = build(:character)
    expect(character).to be_valid
  end
end
