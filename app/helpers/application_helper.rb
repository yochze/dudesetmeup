module ApplicationHelper
	def rand_phrase
		phrases = Array.new
		phrases << "אז מה אם אתה<span style=\"color: #b95959;\">\"In a Relationship\"</span>, זה לא אומר שאתה לא יכול לדאוג לחברים'שך"
		return phrase.sample(1)
	end
end
