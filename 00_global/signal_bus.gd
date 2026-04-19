extends Node

@warning_ignore_start("unused_signal")

signal day_started()

signal task_started(idx: int)
signal task_completed()
signal task_list_complete()

@warning_ignore_restore("unused_signal")
