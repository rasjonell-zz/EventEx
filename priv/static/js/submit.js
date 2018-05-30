$(function() {
  $("#submit").click(() => {
    const title      = $("#title").val();
    const start      = $("#start").val();
    const start_time = $("#start_time").val();
    const end        = $("#end").val();
    const end_time   = $("#end_time").val();
    const color      = $("#event_color").val();

    const start_list = start_time.split(":");
    const end_list   = end_time.split(":");
    const date_start = start.split("-");
    const date_end   = end.split("-");
  
    start_list.forEach((elem) => {
      date_start.push(elem);
    });
    end_list.forEach((elem) => {
      date_end.push(elem);
    });

    const dateStart = new Date(date_start[0], date_start[1], date_start[2], date_start[3], date_start[4]).toISOString();
    const dateEnd   = new Date(date_end[0], date_end[1], date_start[2], date_end[3], date_end[4]).toISOString();
    
    $.ajax({
      url: "api/events/",
      type: "POST",
      data: {"event": {
        "title": title,
        "start": dateStart,
        "end": dateEnd,
        "color": color
        }
      },
      success: result => {
        document.location.href="/";
      }
    })
  });
});
