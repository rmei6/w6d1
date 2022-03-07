class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :title, null:false
      t.integer :author_id, null:false
      t.integer :question_id, null:false
      t.integer :answer_choice_id,  null:false

      t.timestamps
    end
  end
end
