package exfy.user_cp

class TopStatsController {

	TopStatsService topStatsService
	StatsService statsService
	AuthService authService
	GamemodeService gamemodeService

	def index() {
		def stats = topStatsService.topOverview
		def info = topStatsService.topInfo
		Map ranks;
		if (authService.loggedIn) {
			ranks = topStatsService.getTopRanks(authService.uuid)
		} else {
			ranks = [:]
		}

		def realStats = stats.collectEntries {
			[(it.key): [
			        'rank': ranks[it.key],
					'info': info[it.key],
					'stats': it.value
			]]
		}

		render(view: 'index', model: [stats: realStats])
	}

	def gamemode(String id) {
		if (!gamemodeService.gamemodeExists(id)) {
			render(status: 404)
			return;
		}

		def stats = statsService.getStatsForGamemode(id)

		render(view: 'gamemode', model: [stats: stats, gamemode: id])
	}

	def show(String gamemode, String stat) {
		if (!gamemodeService.gamemodeExists(gamemode)) {
			render(status: 404)
			return;
		}

		def info = topStatsService.getInfo(gamemode, stat)
		if (info == null) {
			// stat doesn't exist
			render(status: 404)
			return;
		}

		def top = topStatsService.getStatTop(gamemode, stat)

		render(template: 'show', model: [top: top, info: info])
	}
}
