require_relative '../caesar'

RSpec.describe '#caesar_cipher' do
  it 'shifts letters correctly' do
    expect(caesar_cipher("abc", 1)).to eq("bcd")
    expect(caesar_cipher("xyz", 2)).to eq("zab")
  end

  it 'preserves case' do
    expect(caesar_cipher("AbC", 2)).to eq("CdE")
  end

  it 'keeps non-letter characters unchanged' do
    expect(caesar_cipher("Hello, World!", 5)).to eq("Mjqqt, Btwqi!")
  end

  it 'wraps around the alphabet' do
    expect(caesar_cipher("Zebra", 1)).to eq("Afcsb")
  end

  it 'works with negative shifts' do
    expect(caesar_cipher("bcd", -1)).to eq("abc")
  end
end
