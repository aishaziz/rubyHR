(function(){jQuery(function(){var e;return $("form").on("click",".remove_fields",function(e){return $(this).prev("input[type=hidden]").val("1"),$(this).closest("fieldset").hide(),e.preventDefault()}),$("form").on("click",".add_fields",function(e){var t,n;return n=(new Date).getTime(),t=new RegExp($(this).data("id"),"g"),$(this).before($(this).data("fields").replace(t,n)),e.preventDefault()}),e=$("province").html,$("country").change(function(){var e,t;return e=$({country:selected}).text(),t=$("states").filter("optgroup[label='"+e+"']").html(),t?$("province").html(t):($("province").empty(),$("province").parent.hide())})})}).call(this);