extends Node


func get_enemies_in_range(position, range):
	var enemies = []
	
	for robot in get_tree().get_nodes_in_group("robots"):
		if position.distance_to(robot.global_position) <= range:
			enemies.append(robot)
	
	return enemies


func get_nearest_enemy(position, range):
	var nearest_enemy = null
	var nearest_distance = INF
	
	for robot in get_tree().get_nodes_in_group("robots"):
		var distance = position.distance_to(robot.global_position)
		
		if distance <= range and distance < nearest_distance:
			nearest_enemy = robot
			nearest_distance = distance
	
	return nearest_enemy


func get_strongest_enemy(position, range):
	var strongest_enemy = null
	var highest_health = 0
	
	for robot in get_tree().get_nodes_in_group("robots"):
		var distance = position.distance_to(robot.global_position)
		
		if distance <= range and robot.health > highest_health:
			strongest_enemy = robot
			highest_health = robot.health
	
	return strongest_enemy


func get_random_enemy(position, range):
	var enemies_in_range = []
	
	for robot in get_tree().get_nodes_in_group("robots"):
		if position.distance_to(robot.global_position) <= range:
			enemies_in_range.append(robot)
	
	if enemies_in_range.size() > 0:
		return enemies_in_range.pick_random()
	
	return null
