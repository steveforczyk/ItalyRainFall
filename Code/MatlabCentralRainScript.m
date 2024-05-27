% Assuming data is already loaded into a table 'data_table'
% with variables: 'StationID', 'yyyy', 'mm', 'dd', 'hh', 'mm', 'rain'

% Convert to datetime
data_table.datetime = datetime(data_table.yyyy, data_table.mm, data_table.dd, data_table.hh, data_table.mm, zeros(size(data_table.rain)));

% Sort data just in case it's not in chronological order
data_table = sortrows(data_table, 'datetime');

% Initialize variables
rain_events = table(datetime, datetime, 'VariableNames', {'start_rain', 'end_rain'});
accum_rain = 0;
event_in_progress = false;
hours_without_rain = 0;
last_rain_time = NaT;

% Loop over each row in the table
for i = 1:height(data_table)
    if data_table.rain(i) > 0
        % If this is the first rain in an event, record the start time
        if ~event_in_progress
            start_time = data_table.datetime(i);
            event_in_progress = true;
            accum_rain = 0;  % Reset the accumulated rain
        end
        % Accumulate rain
        accum_rain = accum_rain + data_table.rain(i);
        % Update last rain time
        last_rain_time = data_table.datetime(i);
    elseif event_in_progress
        % Calculate the time since it last rained
        hours_since_last_rain = hours(data_table.datetime(i) - last_rain_time);
        if hours_since_last_rain >= 6
            % If it has been 6 or more hours without rain, record the event
            rain_events = [rain_events; {start_time, last_rain_time}];
            rain_events.h_accum_rain(end+1) = accum_rain;
            event_in_progress = false;
        end
    end
end

% If an event was in progress at the end of the data, record it
if event_in_progress
    rain_events = [rain_events; {start_time, last_rain_time}];
    rain_events.h_accum_rain(end+1) = accum_rain;
end

% Display the results
disp(rain_events)