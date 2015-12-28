%%% Online Command Recognition

addpath('../HMM2 (Digit Recognition)/VOICEBOX');
load( 'hmm_data.mat' , 'hmm');
load( 'setting.mat' , 'fs','bin','fil_num','set_num','loop_num');

%Command Set
comm = ['Bulb           ';'Tubelight      ';'Fan            ';'Television     ';'Air Conditioner';'Projector      ';'Laptop         ';'Cellphone      '];
com = cellstr(comm);
%Recognition
recObj = audiorecorder;
prompt = sprintf('Give Command : \n');
disp(prompt);
recordblocking(recObj,5);
y = getaudiodata(recObj);
y(y==0) = [];
y = filter([1 -0.9375],1,y);
m = melcepst(y,16000,'M',bin,fil_num,256,80);
for j=1:8
    pout(j)=viterbi(hmm{j},m);
end
[d,n] = max(pout);
fprintf('Command recognised as %s\n',com{n});
syscom = ['B:\Application\Python\python.exe interface.py ',com{n}];
system(syscom);