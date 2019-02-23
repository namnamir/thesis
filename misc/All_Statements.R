###########################
# BAR CHART
###########################
# sum of all methods of Web Storage
y = c(67.94045624,52.08789792,95.49555355,76.56270138,10.55548395,1.147055033,0.618636422,5.425956953,78.19951025)
# sum of all methods of WebSQL
y = c(78.84615385,64.42307692,100,50,0,0,0,0,38.46153846)
# sum of all methods of IndexedDB
y = c(91.19135235,80.41628335,99.29852806,90.30013799,69.83095676,12.2125115,3.329116835,33.11867525,49.97700092)
# sum of all interfaces
y = c(80.22354153,67.05034228,97.51317623,83.71599927,41.74895499,6.972799418,2.044587145,19.99757679,63.20651845)

x = c("Variable Declaration", "Function Declaration", "Function Expression", "If Statement", "For Statement", "While Statement", "Do-While Statement", "Switch Statement", "Try Statement")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=4) +
  labs(y = "Percentage", x="Control Flow Statement in all interfaces") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 15)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
