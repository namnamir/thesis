# WebSQL (WSQ) - INSERT INTO
WSQF = sum(result$WSQ_exe_FuD != 0)
WSQI = sum(result$WSQ_exe_IfS != 0)
WSQO = sum(result$WSQ_exe_For != 0)
WSQW = sum(result$WSQ_exe_Whi != 0)
WSQD = sum(result$WSQ_exe_DoW != 0)
WSQC = sum(result$WSQ_exe_Swt != 0)
WSQT = sum(result$WSQ_exe_Try != 0)
WSQV = sum(result$WSQ_exe_Var != 0)
WSQE = sum(result$WSQ_exe_FuE != 0)
WSQS = sum(result$WSQ_exe_ToS != 0)

# WebSQL (WSQ) - UPDATE
WSQF = sum(result$WSQ_upd_FuD != 0)
WSQI = sum(result$WSQ_upd_IfS != 0)
WSQO = sum(result$WSQ_upd_For != 0)
WSQW = sum(result$WSQ_upd_Whi != 0)
WSQD = sum(result$WSQ_upd_DoW != 0)
WSQC = sum(result$WSQ_upd_Swt != 0)
WSQT = sum(result$WSQ_upd_Try != 0)
WSQV = sum(result$WSQ_upd_Var != 0)
WSQE = sum(result$WSQ_upd_FuE != 0)
WSQS = sum(result$WSQ_upd_ToS != 0)

# WebSQL (WSQ) - DELETE FROM
WSQF = sum(result$WSQ_del_FuD != 0)
WSQI = sum(result$WSQ_del_IfS != 0)
WSQO = sum(result$WSQ_del_For != 0)
WSQW = sum(result$WSQ_del_Whi != 0)
WSQD = sum(result$WSQ_del_DoW != 0)
WSQC = sum(result$WSQ_del_Swt != 0)
WSQT = sum(result$WSQ_del_Try != 0)
WSQV = sum(result$WSQ_del_Var != 0)
WSQE = sum(result$WSQ_del_FuE != 0)
WSQS = sum(result$WSQ_del_ToS != 0)

###########################
# BAR CHART
###########################
y = c(WSQV/WSQS*100, WSQF/WSQS*100, WSQE/WSQS*100, WSQI/WSQS*100, WSQO/WSQS*100, WSQW/WSQS*100, WSQD/WSQS*100, WSQC/WSQS*100, WSQT/WSQS*100)
x = c("Variable Declaration", "Function Declaration", "Function Expression", "If Statement", "For Statement", "While Statement", "Do-While Statement", "Switch Statement", "Try Statement")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=4) +
  labs(y = "Percentage", x="Control Flow Statement in DELETE FROM") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 15)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
