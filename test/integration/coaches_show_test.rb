require 'test_helper'

class CoachesShowTest < ActionDispatch::IntegrationTest
   
   def setup
     @coach = coaches(:axwell)
     @other_coach = coaches(:ingrosso)
     @admin = coaches(:axwell)
   end
   
   test "show as correct_coach including delete link" do
     log_in_as(@coach)
     get coach_path(@coach)
     assert_template 'coaches/show'
     assert_select 'a[href=?]', edit_coach_path(@coach)
     assert_select 'a[href=?]', coach_path(@coach), method: 'delete'
     assert_difference 'Coach.count', -1 do
       delete coach_path(@coach)
     end
   end
   
   test "show as in_correct_coach not including delete link" do
     log_in_as(@other_coach)
     get coach_path(@coach)
     assert_template 'coaches/show'
     assert_select 'a[href=?]', edit_coach_path(@coach), count: 0
     assert_select 'a[href=?]', coach_path(@coach), method: 'delete', count: 0
   end
   
end
