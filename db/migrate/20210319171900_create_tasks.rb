class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      # t.float brainshare_required

      t.timestamps
    end
  end
end
