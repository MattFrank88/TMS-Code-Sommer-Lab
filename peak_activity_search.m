%%Find the peak value immediately following the TMS pulse.
thres=0.01;
thresnorm=0.1;
bin_size=3;
endpt=500; 

%Calculate the values for all the peaks following the TMS pulse
for n=1:size(allptsh,1)
    [peak,time]=findpeaks(allptsh(n,4+tbase:end),'MinPeakHeight',thres);
    [pnorm,tnorm]=findpeaks(normptsh(n,4+tbase:end),'MinPeakHeight',thresnorm);
    if size(time,2)>0
        peakVal(n,1)=peak(1);
        timeVal(n,1)=time(1);
    else
        peakVal(n,1)=nan;
        timeVal(n,1)=nan;
    end
    
    if size(tnorm,2)>0
        peakVal(n,2)=pnorm(1);
        timeVal(n,2)=tnorm(1);
    else
        peakVal(n,2)=nan;
        timeVal(n,2)=nan;
    end
end

%Determine the histogram distribution for the stim files
[StBin,timeSt]=hist(timeVal(pSt,1),0:bin_size:endpt);
[StnormBin,tnormSt]=hist(timeVal(pSt,2),0:bin_size:endpt);
%Determine the histogram distribution for the sham files
[ShBin,timeSh]=hist(timeVal(pSh,1),0:bin_size:endpt);
[ShnormBin,tnormSh]=hist(timeVal(pSh,2),0:bin_size:endpt);

figure
subplot(2,1,1)
plot(timeSt,StBin,'bo-',timeSh,ShBin,'go-')
legend('Stim','Sham')
subplot(2,1,2)
plot(tnormSt,StnormBin,'bo-',tnormSh,ShnormBin,'go-')
legend('Stim Normalized','Sham Normalized')
