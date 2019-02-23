TOT = sum(result$Site_Name != "") # total of sites


# INJECT
LST = sum(result$LST_set_Tot != 0)
WSQ = sum(result$WSQ_exe_Tot != 0)
IDB = sum(result2$WSQ_exe_Tot != 0)

LW  = sum(result$LST_set_Tot != 0 & result$WSQ_exe_Tot != 0)
LI  = sum(result$LST_set_Tot != 0 & result2$WSQ_exe_Tot != 0)
WI  = sum(result$WSQ_exe_Tot != 0 & result2$WSQ_exe_Tot != 0)
ALL = sum(result$LST_set_Tot != 0 & result$WSQ_exe_Tot != 0 & result2$WSQ_exe_Tot != 0)

# LOOKUP
LST = sum(result$LST_get_Tot != 0)
WSQ = sum(result$WSQ_upd_Tot != 0)
IDB = sum(result2$WSQ_upd_Tot != 0)

LW  = sum(result$LST_get_Tot != 0 & result$WSQ_upd_Tot != 0)
LI  = sum(result$LST_get_Tot != 0 & result2$WSQ_upd_Tot != 0)
WI  = sum(result$WSQ_upd_Tot != 0 & result2$WSQ_upd_Tot != 0)
ALL = sum(result$LST_get_Tot != 0 & result$WSQ_upd_Tot != 0 & result2$WSQ_upd_Tot != 0)

# DELETE
LST = sum(result$LST_rmv_Tot != 0)
WSQ = sum(result$WSQ_del_Tot != 0)
IDB = sum(result2$WSQ_del_Tot != 0)

LW  = sum(result$LST_rmv_Tot != 0 & result$WSQ_del_Tot != 0)
LI  = sum(result$LST_rmv_Tot != 0 & result2$WSQ_del_Tot != 0)
WI  = sum(result$WSQ_del_Tot != 0 & result2$WSQ_del_Tot != 0)
ALL = sum(result$LST_rmv_Tot != 0 & result$WSQ_del_Tot != 0 & result2$WSQ_del_Tot != 0)

###########################
# BAR CHART
###########################
y = c(LST/TOT*100, WSQ/TOT*100, IDB/TOT*100)
x = c("Web Storage", "WebSQL", "IndexedDB")
d = data.frame(x, y)
ggplot(d, aes(x=x, y=y)) +
  geom_bar(stat="identity", fill="#105e62") +
  geom_text(aes(label=paste(round(y, 2), "%")), vjust=1.6, color="white", size=8) +
  labs(y = "Percentage", x="Interfaces") +
  ylim(0, 100) +
  theme_minimal() + 
  scale_x_discrete(limits=x) +
  theme(text = element_text(size = 20))


###########################
# VENN
###########################
grid.newpage()
draw.triple.venn(area1 = LST,
                 area2 = WSQ,
                 area3 = IDB,
                 n12 = LW,
                 n23 = WI,
                 n13 = LI,
                 n123 = ALL, 
                 category = c("Web Storage", "WebSQL", "IndexedDB"), 
                 lty = "blank",
                 cex = rep(1.5, 7),
                 cat.cex = rep(1.7, 3),
                 print.mode = c("raw", "percent"),
                 fill = c(color_L, color_W, color_I),
                 scaled=TRUE)

