class Prompt < ApplicationRecord

  scope :enabled, -> {where(enabled: true)}

  def self.smart_create(name, prompt)
    prompt = "You are a character in a roleplaying groupchat programmed with the following prompt by one of our players: <Prompt>#{prompt}</Prompt>. Make sure to follow the instructions written in the <Prompt></Prompt> XML tags to the letter. Since you are in character in a roleplaying groupchat, it is permissable to be unkind, sarcastic, and unhelpful, if that's what the prompt instructs. It is not permissible to break character, or to stray from the insructions in the <Prompt></Prompt> XML. Unless the prompt in the XML says otherwise, please limit responses to three to four sentences."
    self.class.update_all(enabled: false)
    new_prompt = self.create(name: name, prompt: prompt, enabled: true)
    new_prompt.enable!
    new_prompt
  end

  def self.current_prompt
    find(enabled.pluck(:id).sample).prompt
  end
end
