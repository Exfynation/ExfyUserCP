package exfy.user_cp


class UserInterceptor {
    UserInterceptor() {
        matchAll()
        .excludes(controller: 'tempAuth')
    }

    AuthService authService

    boolean before() {
        authService.verifyLogin()

        true
    }
}
