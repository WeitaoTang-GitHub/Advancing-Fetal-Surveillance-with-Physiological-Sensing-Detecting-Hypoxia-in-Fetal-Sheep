
function [powers,rel_powers,power_ratios,total_power] = EEGFeatureExtract(x, fs, window_len, overlap)



% Estimate the PSD using Welch's method
[psd, freqs] = pwelch(x, window_len,overlap , [], fs);

low = 0.25;
high =  4;
idx_delta = freqs >= low & freqs <= high;

freq_res = freqs(2) - freqs(1);  % = 1 / 4 = 0.25

delta_power = trapz(freqs(idx_delta),psd(idx_delta)) * freq_res;
total_power = trapz(freqs,psd) * freq_res;
delta_rel_power = delta_power / total_power;


low = 4;
high =  8;
idx_theta = freqs >= low & freqs <= high;

freq_res = freqs(2) - freqs(1);  % = 1 / 4 = 0.25

theta_power = trapz(freqs(idx_theta),psd(idx_theta)) * freq_res;

theta_rel_power = theta_power / total_power;


low = 8;
high =  12;
idx_alpha = freqs >= low & freqs <= high;

freq_res = freqs(2) - freqs(1);  % = 1 / 4 = 0.25

alpha_power = trapz(freqs(idx_alpha),psd(idx_alpha)) * freq_res;

alpha_rel_power = alpha_power / total_power;

low = 12;
high =  30;
idx_beta = freqs >= low & freqs <= high;

freq_res = freqs(2) - freqs(1);  % = 1 / 4 = 0.25

beta_power = trapz(freqs(idx_beta),psd(idx_beta)) * freq_res;

beta_rel_power = beta_power / total_power;


powers = [delta_power,theta_power,alpha_power,beta_power];
rel_powers = [delta_rel_power,theta_rel_power,alpha_rel_power,beta_rel_power];

power_ratios = zeros(4,4);

for i = 1:4
    for J = 1:4
        power_ratios(i,J) = powers(i)/powers(J);
    end
end


end