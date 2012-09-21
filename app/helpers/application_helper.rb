module ApplicationHelper
	def rand_phrase
		phrases = []
		# phrases << "אז מה אם אתה<span style=\"color: #b95959;\">\"In a Relationship\"</span>, זה לא אומר שאתה לא יכול לדאוג לחברים'שך"
		phrases.push("עזוב אחי אתה לא במצב של לסנן..")
		phrases.push("מה נשאר לחברים שלך לעשות? רק להתכופף ולתקוף")
		phrases.push("הוא סבבה והכל אבל.. בלי אבל! סדרי לי אותו!")
		phrases.push("תגידי.. אממ.. אולי תסדרי לי כבר מישהו?!")
		# return phrase.sample(1)
	end
end
