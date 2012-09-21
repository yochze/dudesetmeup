module ApplicationHelper
	def rand_phrase
		phrases = Array.new
		phrases << "אז מה אם אתה<span style=\"color: #b95959;\">\"In a Relationship\"</span>, זה לא אומר שאתה לא יכול לדאוג לחברים'שך"
		phrases << "עזוב אחי אתה לא במצב של לסנן.."
		phrases << "מה נשאר לחברים שלך לעשות? רק להתכופף ולתקוף"
		phrases << "הוא סבבה והכל אבל.. בלי אבל! סדרי לי אותו!"
		phrases << "תגידי.. אממ.. אולי תסדרי לי כבר מישהו?!"
		return phrase.sample(1)
	end
end
