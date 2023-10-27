group = ['A', 'B', 'C', 'D', 'E', 'F']

shuffled = group.shuffle
flag = [3, 4].shuffle

divided = shuffled.each_slice(flag[0]).to_a

p divided[0].sort
p divided[1].sort
