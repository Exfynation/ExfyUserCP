package exfy.user_cp

import org.ocpsoft.prettytime.PrettyTime
import org.springframework.web.servlet.support.RequestContextUtils

class PrettyTimeTagLib {
    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def prettyTime = { attrs, body ->
        def date = attrs.remove("date")
        Date realDate
        if ('org.joda.time.DateTime'.equals(date?.class?.name)) {
            realDate = date.toDate()
        } else if ('java.lang.Long'.equals(date?.class?.name)) {
            realDate = new Date(date)
        } else {
            realDate = date
        }

        if (!date) return

        def prettyTime = new PrettyTime(RequestContextUtils.getLocale(request))
        def result = prettyTime.format(realDate).trim()

        out << result
    }
}
