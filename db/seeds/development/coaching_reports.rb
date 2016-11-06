body =
  "This is a test report.\n" +
  "I'm listening to Andrew Rayel" +
  "and eating cookies." +
  "I'm fuckin' exciting beacouse about a month to go The Ultra Music Festival Japan 2016.\n" +
  "I couldn't go the Fes. so I'm going to get streaming of UMFTV on YouTube." +
  "I wanna go that next year absolutely.\n" +
  "In order to do that, I'm working hard now." +
  "And I wanna watch Rio Olympic,especialy Wrestling now.\n" +
  "でもまだ仕事中で観れないので、予選は我慢して準決勝あたりから観ようと思う。"+
  "決勝は早朝なので観ないかもしれない。"+
  "最後はめんどくさかったので日本語で書いちゃいました。"
%w(coach1 coach2 coach3).each do |name|
  coach = Coach.find_by(name: name)
  1.upto(100) do |idx|
    report = CoachingReport.create(
      title: "coaching_report#{idx}",
      body: body,
      status: %w(draft public_for_coaches unpublic_for_coaches)[idx % 3],
      coach_id: coach.id)
    #report_id = report.id
    #coach_id = coach.id
    #if (idx == 1) || (idx == 2)
    # %w(example4 example5 example6 example7 example8 example9 example10).each do |name2|
    #    favoriters = Coach.find_by(name: name2)
    #    favoriters.favorited_reports << report
    #    Comment.create(
    #      coaching_report_id: report_id,
    #      commented_coach_id: coach_id,
    #      read_flag: false,
    #      body: 'this is a test comment.')
    #  end
    #end
  end
end