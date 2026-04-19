extends Node

@warning_ignore_start("unused_signal")

signal rain_started()
signal rain_ended()

signal color_lighter_added()

signal day_init(idx: int)
signal day_started()
signal day_ended()

signal can_start_task()
signal task_started(idx: int)
signal task_completed()
signal task_list_complete()

signal all_day_completed()
signal game_overed()

signal show_tutor(idx: int)

@warning_ignore_restore("unused_signal")
