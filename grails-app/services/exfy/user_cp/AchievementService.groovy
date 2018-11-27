package exfy.user_cp

import groovy.sql.Sql

class AchievementService {
    Sql deltaSql
    AuthService authService

    def isAvailableCategory(String category) {
        if (authService.loggedIn) {
            isPublicCategoryOrAchieved(category, authService.uuid)
        } else {
            isPublicCategory(category)
        }
    }

    def isPublicCategory(String category) {
        final query = 'SELECT category FROM achievement_categories WHERE hidden = false AND category = :category'

        deltaSql.rows(query, category: category).size() > 0
    }

    def isPublicCategoryOrAchieved(String category, String uuid) {
        final query = 'CALL achievement_check_category_public_auth(:uuid, :category)'

        deltaSql.rows(query, category: category, uuid: uuid).size() > 0
    }

    def isAvailableAchievement(int achievement) {
        if (authService.loggedIn) {
            isPublicOrAchieved(achievement, authService.uuid)
        } else {
            isPublic(achievement)
        }
    }

    def isPublic(int achievement) {
        final query = 'SELECT title FROM achievement_definitions WHERE hidden = false AND id = :id'

        deltaSql.rows(query, id: achievement).size() > 0
    }

    def isPublicOrAchieved(int achievement, String uuid) {
        final query = 'CALL achievement_check_public_auth(:uuid, :id)'

        deltaSql.rows(query, id: achievement, uuid: uuid)
    }

    def getAchievement(int id) {
        final query = 'SELECT category, title, description, id FROM achievement_definitions WHERE id = :id'

        return deltaSql.firstRow(query, id: id)
    }

    def getAvailableCategoryInfo() {
        def results;
        if (authService.loggedIn) {
            results = getCategoryInfoAchieved(authService.uuid)
        } else {
            results = getCategoryInfo()
        }

        def realRes = [:]
        results.each {
            realRes[it.category] = it
        }

        realRes
    }

    def getCategoryInfoAchieved(String uuid) {
        final query = 'CALL achievement_category_info_auth(:uuid)'

        deltaSql.rows(query, uuid: uuid)
    }

    def getCategoryInfo() {
        final query = 'CALL achievement_category_info()'

        deltaSql.rows(query)
    }

    def getAvailableOverviewAchievements() {
        def results;
        if (authService.loggedIn) {
            results = getOverviewAchievementsAuth(authService.uuid)
        } else {
            results = getOverviewAchievements()
        }

        def realRes = [:]

        results.each {
            if (!realRes.containsKey(it.category)) {
                realRes[it.category] = []
            }

            realRes[it.category] << it
        }

        realRes
    }

    def getOverviewAchievementsAuth(String uuid) {
        final query = 'CALL achievements_overview_auth(:uuid)'

        deltaSql.rows(query, uuid: uuid)
    }

    def getOverviewAchievements() {
        final query = 'CALL achievements_overview'
        deltaSql.rows(query)
    }

    def getLastAchieved(int achievement) {
        final query = 'CALL `achievement_last_achieved_by`(:id, 25)'

        deltaSql.rows(query, id: achievement)
    }

    def getAvailableCategoryAchievements(String category) {
        if (authService.loggedIn) {
            getCategoryAchievementsAchieved(category, authService.uuid)
        } else {
            getCategoryAchievements(category)
        }
    }

    def getCategoryAchievementsAchieved(String category, String uuid) {
        final query = 'CALL achievements_category_auth(:uuid, :category)'

        deltaSql.rows(query, uuid: uuid, category: category)
    }

    def getCategoryAchievements(String category) {
        final query = 'SELECT category, title, description, id, hidden, 0 as achieved FROM achievement_definitions WHERE hidden = false AND category = :category ORDER BY order_id ASC'

        deltaSql.rows(query, category: category)
    }
}
