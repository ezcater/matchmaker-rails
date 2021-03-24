class CreateAgents < ActiveRecord::Migration[6.1]
  def change
    create_table :agents do |t|
      # t.float :available_brainshare
      # t.string :skills, array: true, default: []
      # t.string :in_memory, array: true, default: []
      t.timestamps
    end
  end
end
