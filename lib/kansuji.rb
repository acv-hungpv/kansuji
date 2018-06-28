def number_to_kansuji(number)
  initial = { 10**20 => '垓', 10000000000000000 => '京', 1000000000000 => '兆', 100000000 => '億', 10000 => '万',
            1000 => '千', 100  => '百', 10 => '十', 9 => '九', 8 => '八', 7 => '七', 6 => '六', 
            5 => '五', 4 => '四',  3 => '三', 2 => '二', 1 => '一', 0 => '零' }
  return initial[number] if !initial[number].nil? 
  first_number = first_value = second = nil
  initial.each do |key, value| 
    if number/key >= 1
      first_number = number/key
      first_value = value
      second = number - first_number*key
      break
    end
  end
  return (number_to_kansuji(first_number) + first_value + number_to_kansuji(second)) if first_number != 1 && second != 0
  return (first_value + number_to_kansuji(second)) if first_number == 1 && second != 0
  return (number_to_kansuji(first_number) + first_value) if second == 0 && first_number != 1
end
def kansuji_to_number(kansuji)
  initial = { '京' => 10000000000000000, '兆' => 1000000000000, '億' => 100000000, '万' => 10000,
              '千' => 1000, '百' => 100, '十' => 10 ,'九' => 9, '八' => 8, '七' => 7,'六' => 6, 
            '五' => 5,'四' => 4,  '三' => 3, '二' => 2, '一' => 1, '零' => 0 }

  initial1 = { '京' => 10000000000000000, '兆' => 1000000000000, '億' => 100000000, '万' => 10000,
              '千' => 1000, '百' => 100, '十' => 10 }
  return initial[kansuji] if !initial[kansuji].nil?
  temp_init = ""
  new_kansuji = kansuji
  initial1.each do |k, v|
    if(new_kansuji.include?(k))
      temp_init << k
      for i in 0..new_kansuji.length - 1
        if (k == new_kansuji[i])
          new_kansuji = new_kansuji[i..new_kansuji.length-1]
          break
        end
      end
    end
  end
  temp_value = []
  i = 0
  temp = ""
  kansuji.each_char do |element|
    if i == temp_init.length 
       temp_value << element
    elsif temp_init[i] == element
      if temp == ''
        temp_value << '一'
      else
        temp_value << temp
        temp = ''
      end
      i+= 1
    else
      temp << element
    end 
  end
  result = i = 0
  for i in 0..temp_value.length - 1
    if (i == temp_value.length - 1) && temp_init.length < temp_value.length
      result += initial[temp_value[i]]
    else
      result += kansuji_to_number(temp_value[i]) * initial[temp_init[i]]
    end
  end
  return result
end

class Numeric
  def to_kansuji
    return number_to_kansuji(self)
  end
end

class String
  def to_number
    return kansuji_to_number(self)
  end
end 