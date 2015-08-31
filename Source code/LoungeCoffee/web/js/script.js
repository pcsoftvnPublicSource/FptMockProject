$(document).ready(function(){
   /*
    * STICKY TABLE HEADER
    */
    $(".tbl-sticky-header").stickyTableHeaders({
	scrollableArea : $(".scrollable-table")[0],"fixedOffset" : 2});
})