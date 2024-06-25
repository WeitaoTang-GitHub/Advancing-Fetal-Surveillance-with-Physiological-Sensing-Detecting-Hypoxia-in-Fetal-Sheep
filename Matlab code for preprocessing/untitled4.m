% Create a matrix of values to represent the segments of the chart
values = [25, 35, 20, 10, 10;
          15, 20, 30, 15, 20;
          10, 10, 10, 30, 40];

% Create a cell array of labels for each segment
labels = {'Segment 1', 'Segment 2', 'Segment 3', 'Segment 4', 'Segment 5'};

% Create a vector of colors for each segment
colors = ['r', 'g', 'b'];

% Create the bar chart
bar(values, 'stacked');

% Set the x-axis labels
set(gca, 'XTickLabel', labels);

% Set the legend
legend(colors);

% Add axis labels and a title to the plot
xlabel('Segments');
ylabel('Values');
title('Segmented Bar Chart');
