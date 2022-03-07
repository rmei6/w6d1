class CreateAnswerChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_choices do |t|
      t.string  :text, null:false
      t.integer :answer_choice_id, null:false

      t.timestamps
    end
  end
end
