group = ['A', 'B', 'C', 'D', 'E', 'F']

shuffled = group.shuffle
flag = [0, 1].shuffle

if flag[0].zero?
  divided = shuffled.each_slice(3).to_a
else
  divided = shuffled.each_slice(4).to_a
end

p divided[0].sort
p divided[1].sort
