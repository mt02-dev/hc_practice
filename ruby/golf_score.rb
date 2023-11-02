HOLE_IN_ONE = 'ホールインワン'
SCORE_MAPPING = {
  1 => "ボギー",
  0 => "パー",
  -1 => "バーディ",
  -2 => "イーグル",
  -3 => "アルバトロス",
  -4 => "コンドル"
}

score_data = readlines(chomp: true)
the_number_of_strokes_each_hole = score_data[0].split(',').map(&:to_i)
scores_each_hole = score_data[1].split(',').map(&:to_i)

difference_in_scores = scores_each_hole.map.with_index do |score, index|
  score - the_number_of_strokes_each_hole[index]
end

results = []
difference_in_scores.each_with_index do |score, index|
  if the_number_of_strokes_each_hole[index] != 5 && scores_each_hole[index] == 1
    results << HOLE_IN_ONE
    next
  end

  if score > 1
    results << "#{score}#{SCORE_MAPPING[1]}"
    next
  end

  results << SCORE_MAPPING[score]
end
puts results.join(',')
