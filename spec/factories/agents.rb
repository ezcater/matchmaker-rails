# == Schema Information
#
# Table name: agents
#
#  id                   :bigint           not null, primary key
#  available_brainshare :float
#  skills               :string           default([]), is an Array
#  in_memory            :string           default([]), is an Array
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
FactoryBot.define do
  factory :agent do
    
  end
end
