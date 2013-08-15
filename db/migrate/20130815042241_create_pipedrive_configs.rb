class CreatePipedriveConfigs < ActiveRecord::Migration
  def change
    create_table :pipedrive_configs do |t|
      t.string :key
      t.string :value
      t.references :user, index: true

      t.timestamps
    end
  end
end
