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
  initial2 = { '九' => 9, '八' => 8, '七' => 7,'六' => 6, 
            '五' => 5,'四' => 4,  '三' => 3, '二' => 2, '一' => 1, '零' => 0 }
  result = number = 0
  tem_array = ""
  initial1.each do |k, v|
    tem_array << k if(kansuji.include?(k))
  end
  i = j = temp = 0
  kansuji.each_char do |element|
    binding.pry

    if i == tem_array.length || initial[element] < initial[tem_array[i]]  
      if !initial1[element].nil?
        temp += number*initial1[element]
      elsif !initial2[element].nil?
        if j == kansuji.length - 1
          result += initial2[element]
        end
        number = initial2[element]
      end
    elsif (initial[element] == initial[tem_array[i]] && i < tem_array.length)
      if temp != 0
        result += temp * initial1[element]
      elsif number != 0
        result += number * initial1[element]
      else
        result += initial1[element]
      end
      temp = 0
      num = 0
      i += 1
    end 
    j += 1
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