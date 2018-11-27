class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(redirect: "/home/index")
        "/topStats/show/$gamemode/$stat"(controller: 'topStats', action: 'show')
        "500"(view: '/error')
        "404"(view: '/notFound')
    }
}
