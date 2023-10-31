SCORE_NAME_OVER_ZERO = %w[パー ボギー]
SCORE_NAME_UNDER_ZERO = %w[コンドル アルバトロス イーグル バーディ]
HOLE_IN_ONE = 'ホールインワン'

score_data = readlines(chomp: true)
the_number_of_strokes_each_hole = score_data[0].split(',').map(&:to_i)
scores_each_hole = score_data[1].split(',').map(&:to_i)

difference_in_scores = scores_each_hole.map.with_index do |score, index|
  score - the_number_of_strokes_each_hole[index]
end

results = []
difference_in_scores.each_with_index do |score, index|
  if score == -3 && scores_each_hole[index] == 1
    results << HOLE_IN_ONE
    next
  end

  case score
  when -1, -2, -3, -4
    results << SCORE_NAME_UNDER_ZERO[score]
  when 0
    results << SCORE_NAME_UNDER_ZERO[score]
  when 1..nil
    if score > 1
      results << "#{score}#{SCORE_NAME_OVER_ZERO[1]}"
      next
    end
    results << SCORE_NAME_OVER_ZERO[1]
  end
end
p results
