class CreateJobThings < ActiveRecord::Migration
  def change
    create_table :job_things do |t|

      t.timestamps
    end
  end
end
