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
%w(admin).each do |name|
  coach = Coach.find_by(name: name)
  0.upto(100) do |idx|
    CoachingReport.create(
      author: coach,
      title: "coaching_report#{idx}",
      body: body,
      posted_at: 10.days.ago.advance(days: idx),
      status: %w(draft public_for_coaches unpublic_for_coaches)[idx % 3])
  end
end