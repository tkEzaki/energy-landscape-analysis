function mfunc_ActivityMap(vectorList, LocalMinIndex, Name)
% Show activity map

[sy, sx] = size(vectorList);

if (nargin < 3) || isempty(Name)
    Name = 1:sy;
end

dat = vectorList(:,LocalMinIndex);
dat = [dat, dat(:,end)];
dat = [dat; dat(end,:)];

figure(103);
h = surf(dat);
view([0 90]);
colormap([0.3 0.3 0.3;1 1 1]);
%axis ij
axis square

ax = gca;
set(ax, 'FontSize', 14);

len = length(LocalMinIndex);
set(ax, 'Xtick', (1:len) + 0.5);
set(ax, 'XtickLabel', (1:len));
%set(ax, 'XtickLabel', LocalMinIndex);


set(ax, 'Ytick', (1:sy) + 0.5);
% Fix the Name indexing (2018/08)
set(ax, 'YtickLabel', Name);

axis([1 len+1 1 sy+1]);

title('Activity Patterns', 'FontSize', 16);





