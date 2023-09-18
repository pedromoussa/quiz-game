require 'rails_helper'

RSpec.describe Series, type: :model do
  it "is not valid - empty attributes" do
    expect(Series.new).to_not be_valid
  end
  it "is not valid - empty nome_origem" do
    series = build(:series, nome_origem: "")
    expect(series).to_not be_valid
  end
  it "is not valid - empty pais" do
    series = build(:series, pais: "")
    expect(series).to_not be_valid
  end
  it "is not valid - empty popularidade" do
    series = build(:series, popularidade: nil)
    expect(series).to_not be_valid
  end
  it "is not valid - empty media_votacao" do
    series = build(:series, media_votacao: nil)
    expect(series).to_not be_valid
  end
  it "is not valid - empty id_tmdb" do
    series = build(:series, id_tmdb: "")
    expect(series).to_not be_valid
  end
  it "is valid" do
    series = build(:series)
    expect(series).to be_valid
  end
end
