$(function() {
    const getCircularReplacer = () => {
      const seen = new WeakSet;
      return (key, value) => {
        if (typeof value === "object" && value !== null) {
          if (seen.has(value)) {
            return;
          }
          seen.add(value);
        }
          return value;
      };
    };

  
    const HEIGHT = $(window).height();
    let event_list = [];
    
    $.get('api/events', function(data) {
      for(let i=0; i<data.data.length; i++) {
        event_list[i] = data.data[i];
      }

      console.log(event_list);
    });

    $('#calendar').fullCalendar({
      defaultView: 'month',
      themeSystem: 'standard',
      locale: 'hy-am',
      timezone: 'local',
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay,listMonth'
      },
      nowIndicator: true,
      eventColor: 'green',
      customButtons: {
        addEventButton: {
          text: 'Add Event',
          click: function() {
            var dateStr = prompt('Enter a date in YYYY-MM-DD format');
            var date = moment(dateStr);

            if (date.isValid()) {
              $('#calendar').fullCalendar('renderEvent', {
                title: 'dynamic event',
                start: date,
                allDay: true
              });
              alert('Great. Now, update your database...');
            } else {
              alert('Invalid date.');
            }
          }
        }
      },
      events: function(start, end, timezone, callback) {
        $.ajax({
          url: '/api/events',
          dataType: 'json',
          success: function(doc) {
            console.log(doc.data);
            let events = [];
            $.each(doc.data, function(index, value) {
              events.push({
                title: value.title,
                start: value.start,
                end: value.end,
                allDay: value.allDay,
                color: value.color
              });
            });
            callback(events);
          }
        });
      },
      eventClick: function(event) {
        if (event.url) {
          window.open(event.url);
          return false;
        } else {
          alert(`${event.title}, starting at: ${event.start}\n${event.description}`);
        }
      },
      eventMouseover: function(event) {
        $(this).css('cursor', 'pointer')
      }
    });
    
    $('#calendar').fullCalendar('option', 'height', HEIGHT - 130);


  $('#timezone-selector').on('change', function() {
    $('#calendar').fullCalendar('option', 'timezone', this.value || false);
  });

});

