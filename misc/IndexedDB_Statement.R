# IndexedDB (IDB) - objectStore.add (add)
IDBF = sum(result$IDB_add_FuD != 0)
IDBI = sum(result$IDB_add_IfS != 0)
IDBO = sum(result$IDB_add_For != 0)
IDBW = sum(result$IDB_add_Whi != 0)
IDBD = sum(result$IDB_add_DoW != 0)
IDBC = sum(result$IDB_add_Swt != 0)
IDBT = sum(result$IDB_add_Try != 0)
IDBV = sum(result$IDB_add_Var != 0)
IDBE = sum(result$IDB_add_FuE != 0)
IDBS = sum(result$IDB_add_ToS != 0)

# IndexedDB (IDB) - objectStore.get (get)
IDBF = sum(result$IDB_get_FuD != 0 | result$IDB_geA_FuD != 0)
IDBI = sum(result$IDB_get_IfS != 0 | result$IDB_geA_IfS != 0)
IDBO = sum(result$IDB_get_For != 0 | result$IDB_geA_For != 0)
IDBW = sum(result$IDB_get_Whi != 0 | result$IDB_geA_Whi != 0)
IDBD = sum(result$IDB_get_DoW != 0 | result$IDB_geA_DoW != 0)
IDBC = sum(result$IDB_get_Swt != 0 | result$IDB_geA_Swt != 0)
IDBT = sum(result$IDB_get_Try != 0 | result$IDB_geA_Try != 0)
IDBV = sum(result$IDB_get_Var != 0 | result$IDB_geA_Var != 0)
IDBE = sum(result$IDB_get_FuE != 0 | result$IDB_geA_FuE != 0)
IDBS = sum(result$IDB_get_ToS != 0 | result$IDB_geA_ToS != 0)

# IndexedDB (IDB) - objectStore.delete (del)
IDBF = sum(result$IDB_del_FuD != 0)
IDBI = sum(result$IDB_del_IfS != 0)
IDBO = sum(result$IDB_del_For != 0)
IDBW = sum(result$IDB_del_Whi != 0)
IDBD = sum(result$IDB_del_DoW != 0)
IDBC = sum(result$IDB_del_Swt != 0)
IDBT = sum(result$IDB_del_Try != 0)
IDBV = sum(result$IDB_del_Var != 0)
IDBE = sum(result$IDB_del_FuE != 0)
IDBS = sum(result$IDB_del_ToS != 0)

# ALL IndexedDB
IDBF = sum(result$IDB_add_FuD != 0 || (result$IDB_get_FuD != 0 || result$IDB_geA_FuD != 0) || result$IDB_del_FuD != 0)
IDBI = sum(result$IDB_add_IfS != 0 || (result$IDB_get_IfS != 0 || result$IDB_geA_IfS != 0) || result$IDB_del_IfS != 0)
IDBO = sum(result$IDB_add_For != 0 || (result$IDB_get_For != 0 || result$IDB_geA_For != 0) || result$IDB_del_For != 0)
IDBW = sum(result$IDB_add_Whi != 0 || (result$IDB_get_Whi != 0 || result$IDB_geA_Whi != 0) || result$IDB_del_Whi != 0)
IDBD = sum(result$IDB_add_DoW != 0 || (result$IDB_get_DoW != 0 || result$IDB_geA_DoW != 0) || result$IDB_del_DoW != 0)
IDBC = sum(result$IDB_add_Swt != 0 || (result$IDB_get_Swt != 0 || result$IDB_geA_Swt != 0) || result$IDB_del_Swt != 0)
IDBT = sum(result$IDB_add_Try != 0 || (result$IDB_get_Try != 0 || result$IDB_geA_Try != 0) || result$IDB_del_Try != 0)
IDBV = sum(result$IDB_add_Var != 0 || (result$IDB_get_Var != 0 || result$IDB_geA_Var != 0) || result$IDB_del_Var != 0)
IDBE = sum(result$IDB_add_FuE != 0 || (result$IDB_get_FuE != 0 || result$IDB_geA_FuE != 0) || result$IDB_del_FuE != 0)
IDBS = sum(result$IDB_add_ToS != 0 || (result$IDB_get_ToS != 0 || result$IDB_geA_ToS != 0) || result$IDB_del_ToS != 0)

###########################
# BAR CHART
###########################
y = c(IDBV/IDBS*100, IDBF/IDBS*100, IDBE/IDBS*100, IDBI/IDBS*100, IDBO/IDBS*100, IDBW/IDBS*100, IDBD/IDBS*100, IDBC/IDBS*100, IDBT/IDBS*100)
x = c("Variable Declaration", "Function Declaration", "Function Expression", "If Statement", "For Statement", "While Statement", "Do-While Statement", "Switch Statement", "Try Statement")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=4) +
  labs(y = "Percentage", x="Control Flow Statement in get()/getAll()") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 15)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
