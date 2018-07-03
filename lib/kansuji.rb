class Numeric
  def num_to_kan(number)
    init_num_char = { 10**20 => '垓', 10**16 => '京', 10**12 => '兆', 10**8 => '億', 10000 => '万', 
                      1000 => '千', 100 => '百', 10 => '十', 9 => '九', 8 => '八', 7 => '七', 6 => '六', 
                      5 => '五', 4 => '四', 3 => '三', 2 => '二', 1 => '一', 0 => '零' }
    return init_num_char[number] unless init_num_char[number].nil?
    f_num = f_val = second = nil
    init_num_char.each do |key, value|
      (f_num = number / key; f_val = value; second = number - f_num * key; break) if number / key >= 1
    end
    return (num_to_kan(f_num) + f_val + num_to_kan(second)) if f_num != 1 && second != 0
    return (f_val + num_to_kan(second)) if f_num == 1 && second != 0
    return (num_to_kan(f_num) + f_val) if second == 0 && f_num != 1
  end

  def to_kansuji
    num_to_kan(self)
  end
end

class String
  def kan_to_num(kansuji)
    init_char_num = { '垓' => 10**20, '京' => 10**16, '兆' => 10**12, '億' => 10**8, '万' => 10000, 
                      '千' => 1000, '百' => 100, '十' => 10, '九' => 9, '八' => 8, '七' => 7, 
                      '六' => 6, '五' => 5, '四' => 4, '三' => 3, '二' => 2, '一' => 1, '零' => 0 }
    init_decimal_char = { '垓' => 10**20, '京' => 10**16, '兆' => 10**12, '億' => 10**8, '万' => 10000,
                      '千' => 1000, '百' => 100, '十' => 10 }
    return init_char_num[kansuji] unless init_char_num[kansuji].nil?
    index_max = nil
    init_decimal_char.each do |k, _v|
      (index_max = kansuji.index(k); break )if kansuji.include?(k)
    end
    if index_max == 0
      return kan_to_num(kansuji[0]) + kan_to_num(kansuji[1..kansuji.length - 1]) unless kansuji[1].nil?
      return kan_to_num(kansuji[0])
    else
      return kan_to_num(kansuji[0..index_max - 1]) * kan_to_num(kansuji[index_max]) \
            + kan_to_num(kansuji[index_max + 1..kansuji.length - 1]) unless kansuji[index_max + 1].nil?
      return kan_to_num(kansuji[0..index_max - 1]) * kan_to_num(kansuji[index_max])
    end
  end

  def to_number
    kan_to_num(self)
  end
end