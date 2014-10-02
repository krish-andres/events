class CreateCharacterizations < ActiveRecord::Migration
  def change
    create_table :characterizations do |t|
      t.references :event, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
