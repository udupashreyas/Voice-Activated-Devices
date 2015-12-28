clear all
clc;
close all

addpath('../HMM2 (Digit Recognition)/VOICEBOX');
load( 'hmm_data.mat' , 'hmm');
load( 'setting.mat' , 'fs','bin','fil_num','set_num','loop_num');

comm = ['Bulb           ';'Tubelight      ';'Fan            ';'Television     ';'Air Conditioner';'Projector      ';'Laptop         ';'Cellphone      '];
com = cellstr(comm);

count = 0;

for i=1:8
	for j=1:40
		fname = sprintf('Train_Audio/num%dset%d.wav',i,j);
		y = wavread(fname);
		y = filter([1 -0.9375],1,y);
		m = melcepst(y,16000,'M',bin,fil_num,256,80);
		for k=1:8
    		pout(k)=viterbi(hmm{k},m);
		end
		[d,n] = max(pout);
		if strcmp(com{i},com{n})==1
			count = count + 1;
		else
			fprintf('%s recognised as %s\n',com{i},com{n});
		end
	end
end

fprintf('\n\n count = %d\n',count);