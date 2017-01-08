h = get(0,'children');
for i=length(h):-1:1
  saveas(h(i), ['cdma_' num2str(length(h)+1-i)], 'png');
end
