def number_to_kansuji(number)
  initial_num_char = { 10**20 => '垓', 10000000000000000 => '京', 1000000000000 => '兆', 100000000 => '億', 
              10000 => '万', 1000 => '千', 100 =>'百', 10 =>'十', 9 =>'九', 8 =>'八', 7 =>'七', 
              6 =>'六', 5 =>'五', 4 =>'四',  3 =>'三', 2 =>'二', 1 =>'一', 0 =>'零' }
  return initial_num_char[number] if !initial_num_char[number].nil? 
  f_num = f_val = second = nil
  initial_num_char.each do |key, value| 
    if number / key >= 1
      f_num = number / key
      f_val = value
      second = number - f_num * key
      break
    end
  end
  return (number_to_kansuji(f_num) + f_val + number_to_kansuji(second)) if f_num != 1 && second != 0
  return (f_val + number_to_kansuji(second)) if f_num == 1 && second != 0
  return (number_to_kansuji(f_num) + f_val) if second == 0 && f_num != 1
end

def kansuji_to_number(kansuji)
  initial_char_num = { '垓' => 10**20, '京' => 10000000000000000, '兆' => 1000000000000, '億' => 100000000, 
              '万' => 10000, '千' => 1000, '百' => 100, '十' => 10, '九' => 9, '八' => 8, '七' => 7, 
              '六' => 6, '五' => 5,'四' => 4,'三' => 3, '二' => 2, '一' => 1,'零' => 0 }
  initial_decimal_char = { '垓' => 10**20, '京' => 10000000000000000, '兆' => 1000000000000,
                          '億' => 100000000, '万' => 10000, '千' => 1000, '百' => 100, '十' => 10 }
  return initial_char_num[kansuji] if !initial_char_num[kansuji].nil?
  index_max = nil
  initial_decimal_char.each do |k, v|
    if(kansuji.include?(k))
      index_max = kansuji.index(k)
      break
    end
  end
  if index_max == 0
    return kansuji_to_number(kansuji[0]) + kansuji_to_number(kansuji[1..kansuji.length-1])\
       if !kansuji[1].nil?
    return kansuji_to_number(kansuji[0])
  else
    return kansuji_to_number(kansuji[0..index_max - 1])*kansuji_to_number(kansuji[index_max])\
      + kansuji_to_number(kansuji[index_max+1..kansuji.length-1]) if !kansuji[index_max+1].nil?   
    return kansuji_to_number(kansuji[0..index_max - 1])*kansuji_to_number(kansuji[index_max])
  end 
end

class Numeric
  def to_kansuji; return number_to_kansuji(self) end
end

class String
  def to_number; return kansuji_to_number(self) end
end 