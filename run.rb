require './log_analyzer'

log_analyzer = LogAnalyzer.new(*ARGV)
log_analyzer.analyze('GET /api/users/{user_id}/count_pending_messages')
log_analyzer.analyze('GET /api/users/{user_id}/get_messages')
log_analyzer.analyze('GET /api/users/{user_id}/get_friends_progress')
log_analyzer.analyze('GET /api/users/{user_id}/get_friends_score')
log_analyzer.analyze('POST /api/users/{user_id}')
log_analyzer.analyze('GET /api/users/{user_id}')
