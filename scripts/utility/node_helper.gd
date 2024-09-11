class_name NodeHelper

extends Node

##Credit to Theraot and Addmix on StackOverflow 
#https://stackoverflow.com/questions/76313724/check-if-an-object-is-of-a-class-given-the-class-name-in-string
static func is_instance_of_string(obj : Object, given_class_name : String) -> bool:
	if ClassDB.class_exists(given_class_name):
		# We have a build in class
		return obj.is_class(given_class_name)
	else:
		# We don't have a build in class
		# It must be a script class
		var class_script : Script
		# Assume it is a script path and try to load it
		if ResourceLoader.exists(given_class_name):
			class_script = load(given_class_name) as Script
			
		if class_script == null:
			# Assume it is a class name and try to find it
			for x in ProjectSettings.get_global_class_list():
				
				if str(x["class"]) == given_class_name:
					class_script = load(str(x["path"]))
					break
				
		if class_script == null:
			# Unknown class
			return false
		
		# Get the script of the object and try to match it
		var check_script : Script = obj.get_script()
		while check_script != null:
			if check_script == class_script:
				return true
			
			check_script = check_script.get_base_script()
		
		# Match not found
		return false
