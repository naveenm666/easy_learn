class FixFreeOrPaidValues < ActiveRecord::Migration[6.1]
  def up
    Course.where(free_or_paid: '1').update_all(free_or_paid: 'paid')
    Course.where(free_or_paid: '0').update_all(free_or_paid: 'free')
  end

  def down
    Course.where(free_or_paid: 'paid').update_all(free_or_paid: '1')
    Course.where(free_or_paid: 'free').update_all(free_or_paid: '0')
  end
end
