class Prompt < ApplicationRecord

  scope :enabled, -> {where(enabled: true)}

  def enable!
    self.class.update_all(enabled: false)
    update(enabled: true)
  end

  def self.current_prompt
    find(enabled.pluck(:id).sample).prompt
  end
end
