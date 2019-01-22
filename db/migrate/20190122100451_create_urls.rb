class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.text :original_url, null: false
      t.string :shortened_url, null: false, index: true

      t.timestamps
    end
  end
end
