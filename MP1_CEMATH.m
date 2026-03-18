close all; clear all;

% program description
disp('This program computes the area under the curve of a function y = e^(dt)*sin(ct) using a chosen numerical method.');

% user's desired method
reserved = {'a','b','c','d','n','M','v','t','y','dt','reserved', 'areas'};
v = 0
areas = [];
while v == 0
    M = input("Choose an option: \n'1' - for Trapezoidal Rule\n'2' - for Simpson's Rule\n\nWhat is your choice?: ", 's');
    M = str2double(M); % converts '1' into 1 and 'a' into nan
    if isnan(M) || isempty(M) % checks if value is NaN or ''
        disp('Invalid Input!');
    elseif M == 1
       disp('Trapezoidal Rule chosen');
       v = 1;
    elseif M == 2
       disp("Simpson's Rule chosen");
       v = 1;
    else 
       disp('Invalid Input!');
    end
end
v = 0;
% user value inputs
while v == 0
    c = input('Enter value of c for y = e^(dt)*sin(ct) function: ', 's');
    d = input('Enter value of d for y = e^(dt)*sin(ct) function: ', 's');
    if any(strcmp(c, reserved)) || any(strcmp(d, reserved))
        disp('Invalid Input!');
    else
        try % converts numerical strings such as '1', 'pi' into numerical values 
            c = eval(c); 
            d = eval(d); 
        catch % if non-numerical string, change the value to NaN
            c = NaN; 
            d = NaN;
        end
        if (isnan(c) || isempty(c)) || (isnan(d) || isempty(d)) % checks if value is NaN or ''
            disp('Invalid Input!');
        else 
            v = 1;
        end
    end
end
v = 0;
while v == 0
    a = input('Enter lower limit for the integration: ', 's');
    b = input('Enter upper limit for the integration: ', 's');
    if any(strcmp(a, reserved)) || any(strcmp(b, reserved))
        disp('Invalid Input!');
    else
        try % converts numerical strings such as '1', 'pi' into numerical values 
            a = eval(a); 
            b = eval(b); 
        catch % if non-numerical string, change the value to NaN
            a = NaN;
            b = NaN;
        end
        if (isnan(a) || isempty(a)) || (isnan(b) || isempty(b)) % checks if value is NaN or ''
           disp('Invalid Input!');
        elseif(a > b)
           disp('Lower limit should be less than upper limit.')
        else 
           v = 1;
        end
    end
end
v = 0;
while v == 0
    n = input('Enter number of intervals: ', 's');
    if any(strcmp(n, reserved)) 
        disp('Invalid Input!');
    else
        try % converts numerical strings such as '1', 'pi' into numerical values 
            n = eval(n); 
        catch % if non-numerical string, changes the value to NaN
            n = NaN;
        end
         if isnan(n) || isempty(n) || n <= 0 || mod(n,1) ~= 0 % checks if value is NaN, '',is not positive or is a float
                disp('Invalid Input!')
         elseif M == 2 && mod(n,2) ~= 0 % in simpson's rule, interval must be even
                disp('Interval must be even.');
         else
                v = 1;
         end
    end
    
end 

dt = (b - a) / n; % compute delta t
t = a:dt:b;              % t-values
y = exp(d*t) .* sin(c*t); % function values with t-values

% zero crossing points
zc = find(diff(sign(y)));  % finds indices where y changes sign
t(zc); %t-values of the zero crossing points of y

% displays the zero crossing points
fprintf('Zero crossings at t = ');  
fprintf('%.4f ', t(zc));            
fprintf('\n');       


% areas under the curve
% start and end points of zero crossings
zc_full = [1, zc, length(t)];
total_area = 0;
part = 1;

for k = 1 : length(zc_full)-1
    t_part = t( zc_full(k) : zc_full (k+1) );
    y_part = y( zc_full(k) : zc_full (k+1) );
    
    if numel(t_part) < 2 % ensures so that program continues if t_part < 2
        continue;
    end
    
    dt_part = t_part(2) - t_part(1);
    
    n_part = length(t_part) - 1; % number of subintervals in this segment

    if M == 1 % if trapezoidal rule
        
        % first and last ordinates
        first = y_part(1);
        last = y_part(end);

        % sum of remaining ordinates
        remaining_sum = sum(y_part(2:end-1));
        
        % Trapezoidal Rule formula
        area = dt_part * ((0.5 * (first + last)) + remaining_sum);
    
    elseif M == 2 % if simpsons rule
            % first and last ordinates
            first = y_part(1);
            last = y_part(end);

            % odd and even sum of ordinates
            even_sum = sum(y_part(3:2:end-2)); 
            odd_sum  = sum(y_part(2:2:end-1)); 

            % Simpsons rule formula
            area = (dt_part / 3) * (first + last + 4*odd_sum + 2*even_sum);
            
    end
    % get absolute area
    area = abs(area);
    
    fprintf('Area for part %d: %.5f\n', part, area);
    areas(end+1) = area;
    total_area = total_area + area;
    part = part + 1;
end

fprintf('Total area under the Curve: %.4f\n', total_area)

figure;
% t and y are the x and y axis
% b for blue and - solid line and 2 for thickness 
plot(t, y, 'b-', 'LineWidth', 2); hold on; grid on;

% mark zero crossing
plot(t(zc), y(zc), 'ro', 'MarkerFaceColor','r');
xlabel('x');
ylabel('e^(dt)*sin(ct)');
title('Area Under the Curve of y = e^{dt} * sin(ct)');

%shaded areas

zc = zc(zc > 1 & zc < length(t));
shade = [1,zc,length(t)];

for k = 1:length(shade)-1
    if shade(k+1) <= shade(k)
        continue;
    end

    idx = shade(k):shade(k+1);
    if idx(1) < 1 || idx(end) > length(t)
        continue;
    end

    % Create shaded area
    fill([t(idx), fliplr(t(idx))], [y(idx), zeros(size(y(idx)))], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

end

for k = 1:length(shade)-1
    if shade(k+1) <= shade(k) 
        continue; 
    end
    idx = shade(k):shade(k+1);
    if isempty(idx) 
        continue; 
    end
    % plot each area separately
    figure;
    plot(t(idx), y(idx), 'b-', 'LineWidth', 2); hold on; grid on;
    plot(t(idx([1 end])), y(idx([1 end])), 'ro', 'MarkerFaceColor','r');
    %shade each area 
    fill([t(idx), fliplr(t(idx))], [y(idx), zeros(size(y(idx)))], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    xlabel('x');
    ylabel('e^{dt} * sin(ct)');
    title(sprintf('Area = %.5f', areas(k)));
end
