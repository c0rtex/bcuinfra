$(document).ready(function(){
	if (!shebangGetValue('downsize-house') && !shebangGetValue('reverse-mortgage')){
		$(".todo-house.todo-section").remove();
	}
});