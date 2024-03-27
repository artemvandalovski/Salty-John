extends Node2D

# RESTART WITH USING RAYCAST NODES AND NAVIGATION NODES

#func solve(caller: Object, interest_method: String, binds: Array = []) -> Vector2:
	#var result: Vector2 = Vector2.ZERO
	#
	#for i in range(num_rays):
		#var ray: RayCast2D = get_child(i)
		#var ray_dir = ray.cast_to.normalized()
		#
		## Calc interest
		#var interest: float = caller.call(interest_method, ray_dir, binds)
		#
		## Calc danger
		#var rdist: float = view_dist if !ray.is_colliding() else ray.get_collision_point().distance_to(global_position)
		#if rdist == 0: return Vector2.ZERO #prevents some crashes
		#var danger: float = view_dist/rdist * 0.1 * danger_weight
		#
		#if DRAW_DEBUG:
			#imap[i] = interest
			#dmap[i] = danger
		#
		#result += ray_dir * max(interest-danger, 0.0)
	#
	#if DRAW_DEBUG:
		#finaldir = result.normalized()
		#update()
	#
	#return result.normalized()
