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
require 'rails_helper'

RSpec.describe Agent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
