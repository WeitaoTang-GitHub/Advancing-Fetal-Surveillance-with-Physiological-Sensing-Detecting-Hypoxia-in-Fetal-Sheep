function clean_EEG = clean (EEG)  %% EEG is a N*2 matrix of 2 channel EEG (each column corresponds to each channel)
EEG1=EEG(:,1);
EEG2=EEG(:,2);
l=size(EEG,1);

%% Wavelet decomposition
%level = 7;
level=8;
SW_1=modwt(EEG1,'db4', level);
mra_1=modwtmra(SW_1,'db4');
%%% wavelet components for EEG1 
SW_2=modwt(EEG2,'db4', level);
mra_2=modwtmra(SW_2,'db4');
%%% wavelet components for EEG2 


%% Graphing Frequency domains, requires fs defined
% fig_iter = 100;
fs = 400;
% for i = 1:height(mra_1)
%     N = length(mra_1(i,:));
%     omega_Hz1 = (-floor(N/2):(N-1-floor(N/2)))*(fs/N);
%     FFT_CED = fft(mra_1(i,:));
%     figure(fig_iter)
%     hold on
%     plot(omega_Hz1, fftshift(abs(FFT_CED)));
%     xlabel("Frequency (Hz)")
%     ylabel("Amplitude")
%     title("After Wavelet Decomposition Level DB" + i)
%     hold off
%     fig_iter = fig_iter + 1;
% end

WC=[mra_1(1:8,:);mra_2(1:8,:)];
%% kurtosis and entropy extraction
     Wc=WC';
    
    k=kurtosis(Wc)-3;
    for i=1:length(k)
    e(i)= wentropy(Wc(:,i),'shannon');
    end
k=zscore(k); e=zscore(e);
ind1= (k<-1.5) | (k>1.5);
ind2= (e<-1.5) | (e>1.5);
index=ind1|ind2;
%% ICA
 clear('e','k');
 N=length(find(index));
 if (~N)  %%%no artifactual WC -> raw EEG was clean

     EEG1_rec=sum(WC(1:height(WC)/2,:));
     EEG2_rec=sum(WC(height(WC)/2+1:end,:));
     clean_EEG=[EEG1_rec ; EEG2_rec];
 else if ( N==1)
         WIC=WC(index,:);
         weights=[1];
 else

     ICA_input=WC(index,:);  %% artifactual WCs to enter ICA
     [weights,~] = runica(ICA_input,'sphering','off');
     WIC=weights*ICA_input;
 end
frames=floor(l/500); % window of 0.5 s or 500 ms
wic=WIC(:,1:frames*500);
framed=reshape(wic,[N 500 frames]);
framed=permute(framed,[2 1 3]);
%k=moment(framed,4)-3*moment(framed,2).^2; %% kurtosis of each component in each window
k=kurtosis(framed)-3;
k=permute(k, [ 3 2 1]);
k2=k(:);
k2=zscore(k2);
k=reshape(k2,size(k));

i1=(k<-1.5) | (k>1.5);
for i=1:frames
    for j=1:N
        e(j,i)=wentropy(framed(j,:,i),'shannon');
    end
end
e=e';
e2=e(:);
e2=zscore(e2);
e=reshape(e2,size(e));
i2=(e<-1.5) | (e>1.5);
i_final=i1|i2;
reject=find(sum(i_final)>=frames*10/100);
  
WIC(reject,:)=0;
reconstruct=inv(weights)*WIC;
WC(index,:)=reconstruct;

EEG1_rec=sum(WC(1:(height(WC)/2),:));
EEG2_rec=sum(WC((height(WC)/2)+1:end,:));

clean_EEG=[EEG1_rec ; EEG2_rec];

figure(3)
hold on
%xlim(poi) %point of interest
plot(EEG1_rec)
xlabel("Samples at" + fs + " samples/second")
ylabel("Amplitude")
title("Clean EEG Data")
hold off
   
end
