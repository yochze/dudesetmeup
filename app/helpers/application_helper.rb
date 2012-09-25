# encoding: utf-8

module ApplicationHelper
	def randomize_index_phrase
		phrases = []
		phrases << "אז מה אם אתה <span style=\"color: #b95959;\">\"In a Relationship\"</span>, זה לא אומר שאתה לא יכול לדאוג לחברים'שך"
		phrases << "עזוב אחי.. תפרגן לו.. הוא <span style=\"color: #b95959;\">לא במצב של לסנן..</span>"
		phrases << "מה נשאר לחברים שלך לעשות? <span style=\"color: #b95959;\">רק להתכופף ולקטוף</span>"
		phrases << "הוא סבבה והכל אבל.. <span style=\"color: #b95959;\">בלי אבל!</span> סדרי לי אותו!"
		phrases << "תגידי.. אממ.. אולי.. אממ.. נו.. אולי.. <span style=\"color: #b95959;\">אולי תסדרי לי כבר מישהו?!</span>"
		return phrases.sample
	end

	def randomize_happy_phrase
		phrases = []
		phrases << "איזה יופי, שידוך משמים"
		phrases << "dear beloved we are gathered here today"
		phrases << "שמלה כבר יש?"
		phrases << "דיג'יי או להקה?"
		return phrases.sample
	end

	def like_link(match_url)
		"<div class=\"fb-like\" style=\"float: left;\" data-href=\"" + match_url + "\" data-send=\"true\" data-layout=\"button_count\" data-width=\"450\" data-show-faces=\"false\"></div>
             </div>"
	end

end

