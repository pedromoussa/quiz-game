require 'rails_helper'

RSpec.describe Placar, type: :model do
  it "is noy valid - is dependent on user" do
    expect(Placar.new).to_not be_valid
  end
  it "is not valid - empty questoes" do
    placar = build(:placar, questoes: nil)
    expect(placar).to_not be_valid
  end
  it "is not valid - empty acertos" do
    placar = build(:placar, acertos: nil)
    expect(placar).to_not be_valid
  end
  it "is not valid - empty percentual" do
    placar = build(:placar, percentual: nil)
    expect(placar).to_not be_valid
  end
  it "is valid" do
    placar = build(:placar)
    expect(placar).to be_valid
  end
end
