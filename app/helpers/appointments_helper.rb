module AppointmentsHelper

  def generate_ical(events)
    ical_name = "head stories"
    RiCal.Calendar do |ical|
      ical.add_x_property 'X-WR-CALNAME', ical_name
      events.each do |e|
        ical.event do |event|
          if e.start.present? && e.start
            event.dtstart = e.start.to_time.strftime("%Y%m%dT%H%M%S")
          elsif e.start.present?
            event.dtstart = e.start.to_time.strftime("%Y%m%d")
          end
          if e.end.present? && e.end
            event.dtend = e.end.to_time.strftime("%Y%m%dT%H%M%S")
          elsif e.end.present?
            # in ICS müssen ganztägige Termine bis 0 Uhr des nächsten Tages gehen
            event.dtend = (e.end.to_time + 1.day).strftime("%Y%m%d")
          end
          event.summary = e.title
          event.location = "Barbarossastraße 32, Chemnitz, Germany"
          # event.description = e.body
          # event.description = e.category.title
          event.url = root_url[0...-1] + appointment_path(e, token: e.client.authentication_token)
          # event.add_comment("More info at http://yourwebsite.com")
        end
      end
    end.export
  end
end
