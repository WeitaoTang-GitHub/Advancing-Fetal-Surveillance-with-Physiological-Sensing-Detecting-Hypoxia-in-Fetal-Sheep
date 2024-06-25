clear all
close all
% Specify the path to the Excel file you want to import
excel_file_path = 'C:\Users\callu\Documents\2023 UNI\FYP\FYP MATLAB\Data ECG Features (V1).xlsx';

% Specify the sheet name or index within the Excel file to import
sheet_index = 1;

% Call the xlsread function to import the data from the Excel file
[data, header, raw] = xlsread(excel_file_path, sheet_index);


figure(1)

i = 1;
for J = 1:9
    subplot(4,3,J)
    plot(1:4,data(i:i+3,1),'b')
    title((header{i+1,1}(1:5)))
    hold on
    i = i+4;
    
    plot(5:8,data(i:i+3,1),'g')
    
    i = i+4;
    hold on
    if i==33
        i=i+8;
    end
    if i == 73
        i=i+12;
    end
end
sgtitle("Heart Rate| Blue = Baseline | Green = UCO")

for K = 1:9
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end

figure(2)

i = 1;
for J = 1:9 
    subplot(4,3,J)
    plot(1:4,data(i:i+3,2),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,2),'g')
    i = i+4;
    hold on
    if i==33
        i=i+8;
    end
    if i == 73
        i=i+12;
    end
end
sgtitle("Average RR interval| Blue = Baseline | Green = UCO")

for K = 1:9
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end


figure(3)

i = 1;
for J = 1:9
    subplot(4,3,J)
    plot(1:4,data(i:i+3,3),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,3),'g')
    i = i+4;
    hold on
    if i==33
        i=i+8;
    end
    if i == 73
        i=i+12;
    end
end
sgtitle("SDNN| Blue = Baseline | Green = UCO")

for K = 1:9
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end


figure(4)

i = 1;
for J = 1:9
    subplot(4,3,J)
    plot(1:4,data(i:i+3,4),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,4),'g')
    i = i+4;
    hold on
    if i==33
        i=i+8;
    end
    if i == 73
        i=i+12;
    end
end
sgtitle("RMSSD| Blue = Baseline | Green = UCO")

for K = 1:9
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end


figure(7)

i = 1;
for J = 1:9
    subplot(4,3,J)
    plot(1:4,data(i:i+3,7),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,7),'g')
    i = i+4;
    hold on
    if i==33
        i=i+8;
    end
    if i == 73
        i=i+12;
    end
end
sgtitle("LF Power| Blue = Baseline | Green = UCO")

for K = 1:9
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end

figure(8)

i = 1;
for J = 1:9
    subplot(4,3,J)
    plot(1:4,data(i:i+3,8),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,8),'g')
    i = i+4;
    hold on
    if i==33
        i=i+8;
    end
    if i == 73
        i=i+12;
    end
end
sgtitle("HF Power| Blue = Baseline | Green = UCO")

for K = 1:9
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end


figure(9)

i = 1;
for J = 1:9
    subplot(4,3,J)
    plot(1:4,data(i:i+3,9),'b')
    title((header{i+1,1}(1:5)))
    i = i+4;
    hold on
    plot(5:8,data(i:i+3,9),'g')
    i = i+4;
    hold on
   if i==33
        i=i+8;
    end
    if i == 73
        i=i+12;
    end
end
sgtitle("Power Ratio| Blue = Baseline | Green = UCO")

for K = 1:9
    set(subplot(4,3,K), 'XTickLabel', {'Baseline 1', 'Baseline 2', 'Baseline 3', 'Baseline 4','UCO','UCO + 15','UCO + 30','UCO + 45'})
    set(subplot(4,3,K), 'XTickLabelRotation', 60)
end
