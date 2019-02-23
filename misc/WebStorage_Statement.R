# localStorage (LST) - setItem (set)
LSTF = sum(result$LST_set_FuD != 0)
LSTI = sum(result$LST_set_IfS != 0)
LSTO = sum(result$LST_set_For != 0)
LSTW = sum(result$LST_set_Whi != 0)
LSTD = sum(result$LST_set_DoW != 0)
LSTC = sum(result$LST_set_Swt != 0)
LSTT = sum(result$LST_set_Try != 0)
LSTV = sum(result$LST_set_Var != 0)
LSTE = sum(result$LST_set_FuE != 0)
LSTS = sum(result$LST_set_ToS != 0)

# localStorage (LST) - getItem (get)
LSTF = sum(result$LST_get_FuD != 0)
LSTI = sum(result$LST_get_IfS != 0)
LSTO = sum(result$LST_get_For != 0)
LSTW = sum(result$LST_get_Whi != 0)
LSTD = sum(result$LST_get_DoW != 0)
LSTC = sum(result$LST_get_Swt != 0)
LSTT = sum(result$LST_get_Try != 0)
LSTV = sum(result$LST_get_Var != 0)
LSTE = sum(result$LST_get_FuE != 0)
LSTS = sum(result$LST_get_ToS != 0)

# localStorage (LST) - removeItem (rmv)
LSTF = sum(result$LST_rmv_FuD != 0)
LSTI = sum(result$LST_rmv_IfS != 0)
LSTO = sum(result$LST_rmv_For != 0)
LSTW = sum(result$LST_rmv_Whi != 0)
LSTD = sum(result$LST_rmv_DoW != 0)
LSTC = sum(result$LST_rmv_Swt != 0)
LSTT = sum(result$LST_rmv_Try != 0)
LSTV = sum(result$LST_rmv_Var != 0)
LSTE = sum(result$LST_rmv_FuE != 0)
LSTS = sum(result$LST_rmv_ToS != 0)

###########################
# BAR CHART
###########################
y = c(LSTV/LSTS*100, LSTF/LSTS*100, LSTE/LSTS*100, LSTI/LSTS*100, LSTO/LSTS*100, LSTW/LSTS*100, LSTD/LSTS*100, LSTC/LSTS*100, LSTT/LSTS*100)
x = c("Variable Declaration", "Function Declaration", "Function Expression", "If Statement", "For Statement", "While Statement", "Do-While Statement", "Switch Statement", "Try Statement")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=4) +
  labs(y = "Percentage", x="Control Flow Statement in removeItem()") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 15)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
