class CreateJobThings < ActiveRecord::Migration[5.1]
  def change
    create_table :job_things do |t|

      t.timestamps
    end
  end
end
