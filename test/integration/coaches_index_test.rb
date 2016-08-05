require 'test_helper'

class CoachesIndexTest < ActionDispatch::IntegrationTest

  def setup
    @coach = coaches(:axwell)
  end
  
  test "index including pagination" do
    log_in_as(@coach)
    get coaches_path
    assert_template 'coaches/index'
    assert_select 'div.coach-card', 30
    assert_select 'div.pagination'
    Coach.paginate(page: 1).each do |coach|
      assert_select 'a[href=?]', coach_path(coach), text: coach.name
    end
  end
end
