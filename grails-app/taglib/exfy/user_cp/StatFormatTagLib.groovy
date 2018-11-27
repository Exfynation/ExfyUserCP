package exfy.user_cp

class StatFormatTagLib {
	static defaultEncodeAs = [taglib: 'html']
	//static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

	def formatStatistic = { attrs, body ->
		def type = attrs.remove("type")
		def score = Double.parseDouble((String) attrs.remove("score"))

		String ret
		switch (type) {
			case 'INTEGER':
				ret = String.format("%.0f", score)
				break;
			case 'FLOAT':
				ret = String.format("%.2f", score)
				break;
			default:
				throw new RuntimeException("Number type unknown")
		}

		out << ret
	}
}
