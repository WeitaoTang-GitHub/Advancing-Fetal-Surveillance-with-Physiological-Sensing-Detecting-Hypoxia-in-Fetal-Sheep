clear all
close all
clc
% Specify the path to the Excel file you want to import
excel_file_path = 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB\Data EEG Features (V2).xlsx';

% Specify the sheet name or index within the Excel file to import
sheet_index = 1;

% Call the xlsread function to import the data from the Excel file
[data, header, raw] = xlsread(excel_file_path, sheet_index);

figure

i = 1;
for J = 1:10
    subplot(4,3,J)
    plot(1:4,data(i:i+3,1),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,1),'g')
    i = i+4;
    hold on
end
sgtitle("Total POWER| Blue = Baseline | Green = UCO")

for K = 1:10
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end


figure

i = 1;
for J = 1:10
    subplot(4,3,J)
    plot(1:4,data(i:i+3,6),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,6),'g')
    i = i+4;
    hold on
end
sgtitle("Delta Relative POWER| Blue = Baseline | Green = UCO")

for K = 1:10
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end



figure
hold on
i = 1;
for J = 1:10
    subplot(4,3,J)
    plot(1:4,data(i:i+3,7),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,7),'g')
    i = i+4;
    hold on
end
sgtitle("Theta Relative POWER| Blue = Baseline | Green = UCO")

for K = 1:10
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end


figure

i = 1;
for J = 1:10
    subplot(4,3,J)
    plot(1:4,data(i:i+3,8),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,8),'g')
    i = i+4;
    hold on
end
sgtitle("Alpha Relative POWER| Blue = Baseline | Green = UCO")

for K = 1:10
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end


figure

i = 1;
for J = 1:10
    subplot(4,3,J)
    plot(1:4,data(i:i+3,9),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,9),'g')
    i = i+4;
    hold on
end
sgtitle("Beta Relative POWER| Blue = Baseline | Green = UCO")

for K = 1:10
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end