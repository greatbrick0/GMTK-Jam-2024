extends Node
class_name AnimExec

var execActive: bool = true

func ExecuteQueue(queue: Array, displacement: Vector3):
	var timePassed: float = 0.0
	$"../../VisualsOffset".position = -displacement
	
	for ii in queue:
		await get_tree().create_timer(ii[0] - timePassed).timeout
		timePassed = ii[0]
		
		if(!execActive):
			print("cancelled "+name)
			End()
			return
		
		if(ii.size() >= 4): 
			$"../../VisualsOffset".position += ii[3]
		get_parent().animPlayers[ii[1]].play(ii[2])
		
	$"../../VisualsOffset".position = Vector3.ZERO
	print("finished "+name)
	End()

func Skip():
	execActive = false
	for ii in get_parent().animPlayers:
		ii.play("RESET")

func End():
	queue_free()
