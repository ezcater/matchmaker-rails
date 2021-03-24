# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Task < ApplicationRecord
  attr_accessor :brainshare_required,
              :type,
              :taken

  def initialize(attributes = nil)
    super
    @taken = false
  end

  def mark_taken!
    @taken = true
  end
end
