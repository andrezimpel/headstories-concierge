$(document).ready(function() {
  $(".appointment_start, .appointment_end").css('position', 'relative');
  $("#appointment_start, #appointment_end").datetimepicker({
    format: "YYYY-MM-DD HH:mm",
    sideBySide: true,
    stepping: 10,
    calendarWeeks: true,
    icons: {
      time: "fa fa-clock-o",
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: 'fa fa-chevron-left',
      next: 'fa fa-chevron-right',
      today: 'fa fa-screenshot',
      clear: 'fa fa-trash',
      close: 'fa fa-remove'
    }
  });

  $("#appointment_start").on("dp.change", function (e) {
    end_date = moment(e.date).add(1, 'hours');
    $('#appointment_end').data("DateTimePicker").date(end_date);
  });
});
