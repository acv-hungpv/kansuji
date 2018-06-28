require 'rails_helper'
require 'kansuji'

RSpec.describe "parser" do
  it "convert number to kansuji" do 
    expect(89798.to_kansuji).to eq ('八万九千七百九十八')
    expect(9836703.to_kansuji).to eq ('九百八十三万六千七百三')
    expect(2036521801.to_kansuji).to eq ('二十億三千六百五十二万千八百一')
  end

  it "convert kansuji to number" do 
    expect('一万二千六百七十八'.to_number).to eq (12678)
    expect('十二万千八百一'.to_number).to eq (121801)
    expect('一億二千百八十万千六百七十六'.to_number).to eq (121801676)
    expect('五千百二十三万五千三百二十一'.to_number).to eq (51235321)

  end
end