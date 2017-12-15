class AddProTipToTutorialSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :tutorial_steps, :pro_tip, :text
  end
end
