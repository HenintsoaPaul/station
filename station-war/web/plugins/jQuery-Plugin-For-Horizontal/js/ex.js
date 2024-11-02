$(function(){
	$(document).HorizontalBlocks({
		parentBox: "#wrapper",
		block:"#pages>li",
		firstBlock: 1,
		scrollOption:"swing",
		scrollSpeed: "normal",
		horizontalMenu: "nav a",
		nextId: "#next",
		prevId: "#prev"
	});
	SyntaxHighlighter.all();
	$("body").css({"opacity": 1});
});