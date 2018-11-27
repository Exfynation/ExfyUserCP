package exfy.user_cp

class AchievementController {

	AchievementService achievementService

	def index() {
		def achievements = achievementService.availableOverviewAchievements
		def count = achievementService.availableCategoryInfo
		def realAchievements = [:]

		achievements.each {
			realAchievements[it.key] = [
					'info': count[it.key],
					'values': it.value
			]
		}

		render(view: 'index', model: [achievements: realAchievements])
	}

	def category(String id) {
		if (!achievementService.isAvailableCategory(id)) {
			return render(status: 404)
		}

		def achievements = achievementService.getAvailableCategoryAchievements(id)

		render(view: 'category', model: [achievements: achievements, category: id])
	}

	def show(int id) {
		if (!achievementService.isAvailableAchievement(id)) {
			return render(status: 404)
		}

		def players = achievementService.getLastAchieved(id)

		render(template: 'show', model: [players: players])
	}
}
