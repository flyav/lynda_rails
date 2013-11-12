class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :permalink
      t.integer :position
      t.boolean :visible, :default => false
      t.belongs_to :subject, index: true
      t.timestamps
    end
    add_index("pages", "permalink")
  end
end
